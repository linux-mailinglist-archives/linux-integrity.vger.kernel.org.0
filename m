Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C73F4F84
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 19:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhHWRcL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 13:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhHWRcL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 13:32:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE9076126A;
        Mon, 23 Aug 2021 17:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629739888;
        bh=e7y6Lc8now9lIlFwy4u3fzEvUv+8+HIBcAsN2wcm8cQ=;
        h=Subject:From:To:Cc:Date:From;
        b=i1+5RDbbSJm1r34Fjnm9F2V5JjGOpUyQfmF8ILJGk1R0DTyM7Ix6A41Nx6RKuAoMp
         Iz/JHignpYc7a2C4C9V5QP7ADSjcCEwtdWK0d8Z6CFZpKpYJISbvEF2+CckPtbdPQP
         i0MkYB1sTitKy4Ad1lCQigw16OPfnkRL1kV+bD+HmWz2UoNNuB1SkdSrwWEnV6SX7V
         gRD8Rs6Dlnjo6rMCKhv8f79Bbp+5CisPhPJauXSoKxXRzrwtjvThhiJtw4BwE3ZmMk
         vfa3Y1KFmNBmP+sxLLC9ypdLSivROTksAZ4a4t9Bxz1FrRTJ37IjuIhK9C9EPdrTIq
         ZSLq37F1i/1Bw==
Message-ID: <dbb37ec13b79573e1223161383c222a6ab7ac15e.camel@kernel.org>
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.15
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Date:   Mon, 23 Aug 2021 20:31:25 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

These are the highlights of this PR:

- Support for signing LKM's with ECDSA keys.
- An integer overflow bug fix in pkey.

/Jarkko

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93=
:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tag=
s/tpmdd-next-v5.15

for you to fetch changes up to f985911b7bc75d5c98ed24d8aaa8b94c590f7c6a:

  crypto: public_key: fix overflow during implicit conversion (2021-08-23 2=
0:25:24 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.15

----------------------------------------------------------------
Adrian Ratiu (2):
      char: tpm: Kconfig: remove bad i2c cr50 select
      char: tpm: cr50_i2c: convert to new probe interface

Stefan Berger (3):
      certs: Trigger creation of RSA module signing key if it's not an RSA =
key
      certs: Add support for using elliptic curve keys for signing modules
      tpm: ibmvtpm: Avoid error message when process gets signal while wait=
ing

zhenwei pi (1):
      crypto: public_key: fix overflow during implicit conversion

 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        | 21 +++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 drivers/char/tpm/Kconfig              |  1 -
 drivers/char/tpm/tpm_ibmvtpm.c        | 26 +++++++++++++++-----------
 drivers/char/tpm/tpm_ibmvtpm.h        |  2 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c   | 12 ++----------
 include/crypto/public_key.h           |  4 ++--
 8 files changed, 75 insertions(+), 25 deletions(-)
