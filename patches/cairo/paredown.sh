#!/bin/sh

# Copyright 2013  Patrick J. Volkerding, Sebeka, MN, USA
# Modified by Matthew Kuzminski Toronto, ON <szczecinska.duma@gmail.com>
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Remove the reference PNG files from the cairo source tarball.
# These are used only for build time testing, and cairo always fails
# a large number of tests, making these files more or less useless to
# the average end user.  If you really need them for some reason, you
# can fetch the original tarball from cairographics.org.
#
# Removing these files reduces the size of the source tarball by 93%.

PKGNAM=cairo
VERSION=${VERSION:-$(echo $PKGNAM_*.tar.xz | rev | cut -f 3- -d . | cut -f 1 -d - | rev)}

if [ ! -r $PKGNAM_$VERSION.tar.xz ]; then
  echo "$PKGNAM_$VERSION.tar.xz is not a cairo tarball.  Exiting."
  exit 1
fi

touch -r $PKGNAM_$VERSION.tar.xz tmp-timestamp || exit 1

rm -rf $PKGNAM_$VERSION
tar xvf $PKGNAM_$VERSION.tar.xz || exit 1
rm -f $PKGNAM-1.13.1/test/reference/*
rm -f $PKGNAM_$VERSION.tar.xz
tar cvf $PKGNAM_$VERSION.tar $PKGNAM-1.13.1
touch -r tmp-timestamp $PKGNAM_$VERSION.tar
xz -9 -v $PKGNAM_$VERSION.tar
rm -rf $PKGNAM-1.13.1 tmp-timestamp

echo "Repacking of $PKGNAM-$VERSION.tar.xz complete."

