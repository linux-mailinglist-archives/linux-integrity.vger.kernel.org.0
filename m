Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE4197E71
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgC3OeR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 10:34:17 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:33662 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgC3OeQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 10:34:16 -0400
Received: by mail-wm1-f42.google.com with SMTP id z14so3332250wmf.0
        for <linux-integrity@vger.kernel.org>; Mon, 30 Mar 2020 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bKwCbj/7u8Mwt7KAJwrgP8YzZbWuAGtbAXm2Mxbwqls=;
        b=TBFyy9vopRY0rJfKEDWkPLR8663xyIdFF0rWARzBamosNLH3wATPZvvISuj0XkZzEt
         9CWjn8sS6HAaOwAS7j6aKciQPtC1dJ3KtvtDdodgUbcVBLhHoRjxvSPk+H4eGmftwGes
         qOJg9/PXU8tP0SKfnNeIh8EFUR+FQhDXPITBd+0MSA/HE5FkyzLfQJHG6/VYKmNl3V0D
         LcAHxsgomTEnOG+APKkZr3HRCigZninyNmLiamSza1mIpA9CiZLypumn+QSDtOCl2xDo
         QLJwSJ+XVoPF40i+GqabJ0JHrHDjfDTV9/IzJQetHrkvjlFI4qUH3+E9DSXbo61Cx8Nc
         fwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bKwCbj/7u8Mwt7KAJwrgP8YzZbWuAGtbAXm2Mxbwqls=;
        b=KFq+s76JumtM0S6gvLbqrZgs9ZmZmNOIHWIamWQFo7lfwsmP9lExQpe8lo7243Iyiu
         GjIAGE0tjfz0rQxWPAPpfseSfr+GpSXcuhcjo7LeFOLdTsMg6cbFvhyGzyJljR7UHgjs
         y0x28DQsEsGvlbTtL/32DjfRIu2UQoTK+vd5JIM55XuRWQ2+Tfd0CzO34Lnl6NP+LkBf
         0IrqUzx0EjFTpi7mt0yNeNCTkUJ1J53W00MZ/KH6+eHxnGcD052PXznApRRbnRFwMAhj
         MHMwh4fl44Wv0xC4humOEDRsLQLaSH3ymrUDsfi5X0kzHYdF6JQsc2SoH7SFDv7YtDip
         jvhw==
X-Gm-Message-State: ANhLgQ2ml7OwyQw+/RlZYa9dJjdCLuFzdpLNC+an5evIUUp4T0DjRzfO
        Mav9aqWcMIv9LPN8YEBVtTHXGGbD1g9bU6wxPnw=
X-Google-Smtp-Source: ADFU+vvhXUWrTCwe0E093BzEaf+TS7KxaHuoDQHnxEmiXKtrIvIIzdjrIwIyiUUf5wwg/ElYnsTnzpktP42YKgPHFZE=
X-Received: by 2002:a1c:f205:: with SMTP id s5mr13303447wmc.101.1585578854029;
 Mon, 30 Mar 2020 07:34:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Lev R. Oshvang ." <levonshe@gmail.com>
Date:   Mon, 30 Mar 2020 17:34:02 +0300
Message-ID: <CAP22eLGoCUcLyGn3yOBXW7jYWdYVAH3hvtA9QdPVJ9_OC9R7Ow@mail.gmail.com>
Subject: Subject: [PATCH] integrity - add more inode metadata to signature
To:     Mimi Zohar <zohar@us.ibm.com>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From 9f6cf77a341939a012fb2c114c6cf23821ffaedc Mon Sep 17 00:00:00 2001
From: Lev Olshvang <levonshe@gmail.com>
Date: Mon, 30 Mar 2020 16:00:27 +0300
Subject: [PATCH] integrity - add more inode metadata to signature

Add another 2 inode fields to inode hash: size and flags.
File flags may have immutable flag set which I consider important
security indicator.
File systems may use other flags which attacker may tweak to change behavior.
Having original file size may improve IMA performance (although some
code redesign is required).  If we are evident to file size
change, we can spare IMA from other read operations and checks.

Signed-off-by: Lev Olshvang <levonshe@gmail.com>
---
 security/integrity/evm/evm_crypto.c | 30 +++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c
b/security/integrity/evm/evm_crypto.c
index d485f6fc908e..76703413952d 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -139,15 +139,18 @@ static struct shash_desc *init_desc(char type,
uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
                          char type, char *digest)
 {
+       int rc = 0;
        struct h_misc {
                unsigned long ino;
                __u32 generation;
                uid_t uid;
                gid_t gid;
                umode_t mode;
+               __u32   filesize;
+               __u32   flags;
        } hmac_misc;

        memset(&hmac_misc, 0, sizeof(hmac_misc));
@@ -169,11 +172,24 @@ static void hmac_add_misc(struct shash_desc
*desc, struct inode *inode,
        hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
        hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
        hmac_misc.mode = inode->i_mode;
-       crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+       hmac_misc.flags = inode->i_flags;
+       /* hardly imagine calculating hash for file  > 4G */
+       if (likely(inode->i_size < 0xFFFFFFFF))
+               hmac_misc.filesize = (__u32) inode->i_size;
+       else
+               return -E2BIG;
+
+       rc = crypto_shash_update(desc, (const u8 *)&hmac_misc,
sizeof(hmac_misc));
+       if (unlikely(!rc))
+               return rc - __LINE__;
        if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-           type != EVM_XATTR_PORTABLE_DIGSIG)
-               crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid,
UUID_SIZE);
-       crypto_shash_final(desc, digest);
+           type != EVM_XATTR_PORTABLE_DIGSIG) {
+               rc = crypto_shash_update(desc, (u8
*)&inode->i_sb->s_uuid, UUID_SIZE);
+               if (unlikely(!rc))
+                       return rc - __LINE__;
+       }
+       rc = crypto_shash_final(desc, digest);
+       return rc;
 }

 /*
@@ -239,7 +255,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
                if (is_ima)
                        ima_present = true;
        }
-       hmac_add_misc(desc, inode, type, data->digest);
+       error = hmac_add_misc(desc, inode, type, data->digest);
+       if (error < 0)
+               return error;

        /* Portable EVM signatures must include an IMA hash */
        if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
--
2.17.1
