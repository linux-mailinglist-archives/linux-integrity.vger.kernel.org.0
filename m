Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6E166766
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2020 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBTTqF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Feb 2020 14:46:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTTqF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Feb 2020 14:46:05 -0500
Received: from dhcp-9-31-102-231.watson.ibm.com (unknown [129.34.9.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABC28206F4;
        Thu, 20 Feb 2020 19:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582227965;
        bh=fWj4DricUfMFagu/vY1UD5Ak4KseFe0NphU6bFhigEk=;
        h=Subject:From:To:Cc:Date:From;
        b=Vsl69bltoqHLqv4yfsvsiBB8zK97DHc1G1Cj/PK0ciqD+Z59dlrOA6LNHeh7GaE8S
         PRXKGrQxQvjKAEpkaSXapAO7n6ELO+WNEr9hcUeyPYHApFWZqaKmYa9m8GZDQU5d3I
         416r4uGWRx3Qy6o2TVzZQIVdsN+YXAX/6k7j4zfA=
Message-ID: <1582227963.19057.17.camel@kernel.org>
Subject: [GIT PULL] integrity subsystem fixes for v5.6
From:   Mimi Zohar <zohar@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Feb 2020 14:46:03 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Here are two bug fixes and an associated change for each.  The one
that adds SM3 to the IMA list of supported hash algorithms is a simple
change, but could be considered a new feature.

thanks,

Mimi


The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity

for you to fetch changes up to 5780b9abd530982c2bb1018e2c52c05ab3c30b45:

  ima: add sm3 algorithm to hash algorithm configuration list (2020-02-18 07:35:49 -0500)

----------------------------------------------------------------
Ard Biesheuvel (1):
      x86/ima: use correct identifier for SetupMode variable

Javier Martinez Canillas (1):
      efi: Only print errors about failing to get certs if EFI vars are found

Tianjia Zhang (2):
      crypto: rename sm3-256 to sm3 in hash_algo_name
      ima: add sm3 algorithm to hash algorithm configuration list

 arch/x86/kernel/ima_arch.c                    |  6 ++--
 crypto/hash_info.c                            |  2 +-
 security/integrity/ima/Kconfig                |  5 ++++
 security/integrity/platform_certs/load_uefi.c | 40 +++++++++++++++++----------
 4 files changed, 34 insertions(+), 19 deletions(-)
