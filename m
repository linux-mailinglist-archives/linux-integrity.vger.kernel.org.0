Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE6724203C
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Aug 2020 21:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKT0k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Aug 2020 15:26:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44120 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKT0k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Aug 2020 15:26:40 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id DA78D20B4908;
        Tue, 11 Aug 2020 12:26:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA78D20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597173999;
        bh=CbZB5tawklHmwHwPGGSv4PkTsLyp5HU3XULolWuLO6g=;
        h=From:To:Cc:Subject:Date:From;
        b=JKsubR1ofM8X2csKRjtC8LWR3MW5OVIfNeHz5YIfNFhE/zgbzfloFZ/hQDZcGoG1B
         Yk1U8PCHT+M6D7azt6pOxFiu9gALwU9CnmjWYvcqUa6sq3wRLsNZw+3vRm75DhFtWi
         bt3IyXxvy5D8WqXm9LFH0hzr6P2fqnj8/FrzK5P4=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/2] ima: Fix keyrings race condition and other key related bugs
Date:   Tue, 11 Aug 2020 14:26:19 -0500
Message-Id: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

v2:
 - Always return an ERR_PTR from ima_alloc_rule_opt_list() (Nayna)
 - Add Lakshmi's Reviewed-by to both patches
 - Rebased on commit 3db0d0c276a7 ("integrity: remove redundant
   initialization of variable ret") of next-integrity
v1: https://lore.kernel.org/lkml/20200727140831.64251-1-tyhicks@linux.microsoft.com/

Nayna pointed out that the "keyrings=" option in an IMA policy rule
should only be accepted when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is
enabled:

 https://lore.kernel.org/linux-integrity/336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com/

While fixing this, the compiler warned me about the potential for the
ima_keyrings pointer to be NULL despite it being used, without a check
for NULL, as the destination address for the strcpy() in
ima_match_keyring().

It also became apparent that there was not adequate locking around the
use of the pre-allocated buffer that ima_keyrings points to. The kernel
keyring has a lock (.sem member of struct key) that ensures only one key
can be added to a given keyring at a time but there's no protection
against adding multiple keys to different keyrings at the same time.

The first patch in this series fixes both ima_keyrings related issues by
parsing the list of keyrings in a KEY_CHECK rule at policy load time
rather than deferring the parsing to policy check time. Once that fix is
in place, the second patch can enforce that
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS must be enabled in order to use
"func=KEY_CHECK" or "keyrings=" options in IMA policy.

The new "keyrings=" value handling is done in a generic manner that can
be reused by other options in the future. This seems to make sense as
"appraise_type=" has similar style (though it doesn't need to be fully
parsed at this time) and using "|" as an alternation delimiter is
becoming the norm in IMA policy.

This series is based on commit 311aa6aafea4 ("ima: move
APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime") in
next-integrity.

Tyler

Tyler Hicks (2):
  ima: Pre-parse the list of keyrings in a KEY_CHECK rule
  ima: Fail rule parsing when asymmetric key measurement isn't
    supportable

 security/integrity/ima/ima_policy.c | 142 +++++++++++++++++++---------
 1 file changed, 96 insertions(+), 46 deletions(-)

-- 
2.25.1

