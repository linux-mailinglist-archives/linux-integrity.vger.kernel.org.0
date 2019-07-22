Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC970B47
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 23:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbfGVV0c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 17:26:32 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:45154 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728822AbfGVV0b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 17:26:31 -0400
Received: by mail-ua1-f54.google.com with SMTP id v18so16041176uad.12
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jul 2019 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l2Brdo1rNZvuSD22e+nqM8rJ22yxnkGA3xtPR6++HuY=;
        b=PXXstqpO2akfG1tt9r0mvd1b6o7bc7jrEhWUqvADxoc0RafTGjQkH5+9K0f1oFdmiJ
         AH00BQGlhqvhipZdN9W+pmzNCVb/A21u5xRA0BvxOk6AB1vrnGJJRGNMXBkFx3XlZ/2h
         jK6gceEjDK7lwSt8HnaDfEazhlkfy0P7/5FGyvuE7qBRBvk9RaU6EMcy4mo1RH4cRyji
         qpuPwrPfqujflJL7YXiKQYkxLUL4ihOpVTooXCcK8xS+OnxeVjIFDPspU3kQbOezERB6
         +ZAosIcPexxzMpgbHaUFurILKDR6PD4WdV52TvNbzX263MHorC9tfDjBYfFtLT5GSuFE
         /wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l2Brdo1rNZvuSD22e+nqM8rJ22yxnkGA3xtPR6++HuY=;
        b=Cz0sA1XMm1rUMPdbUzTnZzgNs+Rznw+wJbblT1EYSEEwuMUVw+ibPyaFyz/JZ4R6f9
         c6q4IXzdKinxz+6wmBcDAG/tOeN/Knzlf0TdXpS3oi3RtK6UMLhME1ShVwEtOTLdii9w
         ruoxb072KCGW90YOKXeLt2t/25qU90FDqCFqdZNvQAFeugq+xM6wyRqYPw8Vghh+o1Cl
         NSDkFKlI4zT8fqqQOoDsCamqhOgvcYwEBlW9fEcOTFNeheSpylbOSnB9OaqwIIHcttsb
         W0GqJWy2tt+kInqUVc7ibRyh4WY9Q6zrtcKNgqUDGOjmyQKi4qIKVpAloZa+RP8cJhMB
         ZC9Q==
X-Gm-Message-State: APjAAAVBHPVWVtNZURZepcSezRtOk5NX/GbIUhs4tOt453uB2u9SQCKF
        Oii7mPydDY9jlSYQn96KJmQ1JAvyQudsqyF5ftdIKaUV
X-Google-Smtp-Source: APXvYqwmjHGtDNej+RYK73D9CHf/BB9DGZeiCOv2Vh6qfKqzULl6ANTizNZ0dLBnNFA6mPXn/kYxSuP54j5KoKFK2oA=
X-Received: by 2002:ab0:2789:: with SMTP id t9mr28440508uap.69.1563830790899;
 Mon, 22 Jul 2019 14:26:30 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Mon, 22 Jul 2019 22:26:20 +0100
Message-ID: <CABatt_zVj_V6ms7NF_zGhtibkfVL7hK4a65NTFhhF6mN=ZAtUg@mail.gmail.com>
Subject: ubifs assert when creating a SMACK transmuting directory.
To:     linux-mtd@lists.infradead.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

The following backtrack was reported by our dev team.

[<8010ea60>] (unwind_backtrace) from [<8010c4d8>] (show_stack+0x10/0x14)
[<8010c4d8>] (show_stack) from [<803b590c>] (ubifs_xattr_set+0x210/0x3ec)
[<803b590c>] (ubifs_xattr_set) from [<80272134>] (__vfs_setxattr+0x70/0x80)
[<80272134>] (__vfs_setxattr) from [<803ecd8c>]
(smack_d_instantiate+0x41c/0x430)
[<803ecd8c>] (smack_d_instantiate) from [<803e4ef0>]
(security_d_instantiate+0x34/0x54)
[<803e4ef0>] (security_d_instantiate) from [<80263edc>]
(d_instantiate+0x28/0x4c)
[<80263edc>] (d_instantiate) from [<80392858>] (ubifs_mkdir+0x1f8/0x200)
[<80392858>] (ubifs_mkdir) from [<80257124>] (vfs_mkdir+0x148/0x1dc)
[<80257124>] (vfs_mkdir) from [<8025add8>] (SyS_mkdirat+0x84/0xec)
[<8025add8>] (SyS_mkdirat) from [<80107dfc>] (__sys_trace_return+0x0/0x10)

Looking at the code for smack_d_instantiate it's going down the following path
/*
 * Transmuting directory
 */
if (S_ISDIR(inode->i_mode)) {
        /*
         * If this is a new directory and the label was
         * transmuted when the inode was initialized
         * set the transmute attribute on the directory
         * and mark the inode.
         *
         * If there is a transmute attribute on the
         * directory mark the inode.
         */
        if (isp->smk_flags & SMK_INODE_CHANGED) {
                isp->smk_flags &= ~SMK_INODE_CHANGED;
                rc = __vfs_setxattr(dp, inode,
                        XATTR_NAME_SMACKTRANSMUTE,
                        TRANS_TRUE, TRANS_TRUE_SIZE,
                        0);
        } else {
which ends up in ubifs_xattr_set which is expecting the inode
semaphore to be locked and hence the assert message.

I can reproduce this by creating a directory with SMACK64TRANSMUTE and
then adding a rule with 't' set and then creating a directory

mkdir test
chmod 777 test
chsmack -a update test
chsmack -t test

echo programmingapp > /proc/self/attr/current
echo programmingapp update rwxat > /sys/fs/smackfs/load2

Creating a directory in test which trigger the ubifs assert.

Looking at the code some more, don't we need to lock the inode when
calling __vfs_setxattr above as the inode will have already been
created (ubifs_init_security in ubifs_mkdir) and added to the inode
hash and another process could potentially set an extended attribute
on the directory whilst we are trying to add the transmute attribute
here?

I created a patch which put an inode_trylock around __vfs_setxattr and
the ubifs assert has now disappeared in the use case described.
Although this fixes things for a UBIFS I had a quick look at other
filesystems to see how they handle setting extended attributes and the
2 I looked at have a i_xattr_sem which is in some wrapper structure
around an inode so maybe this isn't the best solution but maybe the
inode_trylock should be moved into the ubifs_xattr_set function
instead of the

if (check_lock)
        ubifs_assert(c, inode_is_locked(host));

to be more in line with what the other filesystems do.  This is on a
4.9 vendor kernel for an i.MX system but looking at 5.2 I think the
problem would still exist but not entirely sure.  Either way is
replacing the above check with inode_trylock a valid solution or is
there a better way of solving this?

Many Thanks,
Martin.
