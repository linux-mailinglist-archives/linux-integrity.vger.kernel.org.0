Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211B5ED092
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 00:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiI0W4t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiI0W4p (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351A80F50
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 15:56:41 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id z18-20020a9d65d2000000b0065c3705f7beso2991245oth.9
        for <linux-integrity@vger.kernel.org>; Tue, 27 Sep 2022 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VhU2M30mPXzl6yzEPDfyAe1FzeUf2j8Qu8orpZvxf7A=;
        b=fOZRgCa5NAKFIm/qIhOsmvEx3hdUlYJ7QZdvw01xCZKXyQFW1BYUicDLbrK8cIkEDY
         XImOI7doLlIt7dB3Bbi8O9/PN60SZoPBz/O38SONrMuvM0Cm3ZoGMbm/dRQsrBf1DLPN
         uPZFkde3M15D2n/qmhhPpyqjmWXF7yPKOIKGAcqC/74NVsMgsElGP6VzMRbhBxVuu5Dl
         M58wzHYYr4lREBqubmNWeTKG0ii2LClTupTYDiP921Cwt46QYO2CB8vCkd6qVqU82ZNW
         isLCY+4K+gatgVuIlretOJMBd7ZeMgXCCawBZCiUD4CeTWBuazFG1Wfnwbj9MRZATWG2
         ZfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VhU2M30mPXzl6yzEPDfyAe1FzeUf2j8Qu8orpZvxf7A=;
        b=rhYnGQhxhhIAH1LzCYEQjnMHHlMXb1WPro3nmPiP9EkKkseIKZHlok8aXcZTJkb9y3
         tmY9OjhdJzFeOpQ6b16cb10ECOmKzZ1j6pVntKyCtoN1eWER/u/T3p32vJVXB+6PDfbq
         voA2t2XESs2qSulT0gmBQvW5lka/y9kuE+xRCVG8vMKbngEMEm6DVtKWBuUfHcbqNs47
         I7qNZpR8Oalspn38oeyIOjtDDvJrpGaPdlBLTb2Bk0xvJBo3ZMoa0vQ6joMpBjwQwD/m
         PcTeeB9dfHy6chsMLL0S/kpjk/6g7+hnFDT6ahZu80rd4xeSTlKTtNZFHXeIlQ90CkZ5
         dGow==
X-Gm-Message-State: ACrzQf1qrt9Ka6KdbF9iepagZAOY+/d+Av7DVJAsiK6QV6thQqVd/j32
        sWzts6yxF2T121KkHUE3FI11kt7UN2jUdD3YkE4z
X-Google-Smtp-Source: AMsMyM4ON3IQFaMBaXAGTJIu4Z8RHjcuiG/+2xhk0+VmPQisVNn0kC8pJZB5fYaPLtNHrkLfrm/iVa6V3204XbJgmZI=
X-Received: by 2002:a05:6830:114f:b0:655:bd97:7a9b with SMTP id
 x15-20020a056830114f00b00655bd977a9bmr13279196otq.287.1664319401122; Tue, 27
 Sep 2022 15:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-16-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-16-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:56:30 -0400
Message-ID: <CAHC9VhS_8OeVNiXbcf9q1BX00pQQW2meC2eh9iV3WwgJ0iNxJg@mail.gmail.com>
Subject: Re: [PATCH v2 15/30] evm: add post set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The security_inode_post_setxattr() hook is used by security modules to
> update their own security.* xattrs. Consequently none of the security
> modules operate on posix acls. So we don't need an additional security
> hook when post setting posix acls.
>
> However, the integrity subsystem wants to be informed about posix acl
> changes and specifically evm to update their hashes when the xattrs
> change. The callchain for evm_inode_post_setxattr() is:
>
> -> evm_inode_post_setxattr()
>    -> evm_update_evmxattr()
>       -> evm_calc_hmac()
>          -> evm_calc_hmac_or_hash()
>
> and evm_cacl_hmac_or_hash() walks the global list of protected xattr
> names evm_config_xattrnames. This global list can be modified via
> /sys/security/integrity/evm/evm_xattrs. The write to "evm_xattrs" is
> restricted to security.* xattrs and the default xattrs in
> evm_config_xattrnames only contains security.* xattrs as well.
>
> So the actual value for posix acls is currently completely irrelevant
> for evm during evm_inode_post_setxattr() and frankly it should stay that
> way in the future to not cause the vfs any more headaches. But if the
> actual posix acl values matter then evm shouldn't operate on the binary
> void blob and try to hack around in the uapi struct anyway. Instead it
> should then in the future add a dedicated hook which takes a struct
> posix_acl argument passing the posix acls in the proper vfs format.
>
> For now it is sufficient to make evm_inode_post_set_acl() a wrapper
> around evm_inode_post_setxattr() not passing any actual values down.
> This will still cause the hashes to be updated as before.
>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  fs/posix_acl.c      |  5 ++++-
>  include/linux/evm.h | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
