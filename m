Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30804597428
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Aug 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiHQQcC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiHQQcB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 12:32:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B4A1115B
        for <linux-integrity@vger.kernel.org>; Wed, 17 Aug 2022 09:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D16B81E43
        for <linux-integrity@vger.kernel.org>; Wed, 17 Aug 2022 16:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99E3C433D6;
        Wed, 17 Aug 2022 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660753916;
        bh=jvcej5VUUiLy+OCfFavyXIPWUwdRPithcw39F26VNmg=;
        h=Date:From:To:Cc:Subject:From;
        b=akmU8bM0Rhe0Z+w4vfV5zqAb5dEX7K3+VNq1PqZeyff8j0iuLzKc5hyO9sO8IcIDF
         gqVYIoOlitpBqPK4dMhdicJk3+m+o0pRboq5B5AQCj4K0nIX33hg0r8RI3kb9nbenQ
         rNFerqtpgy8Y3IPI4rT3TnU3rGn50AY+l1jyVqcScZWBeRxjMyJGe9/xMf6XiruGLU
         axNSQJtC7tA3h3NPdsRjyhvsfEjVtFkilK95k9GAB04kzl0dpSlWl0cQQOKIgJhPIF
         e8y8RHB6liT8zNqmEmKjgyDBfpID/v85sn9pHJ0/3efT0A/Omv4Y+6ZXaEfv8DEQQT
         m7mxz7xRM7Ulw==
Date:   Wed, 17 Aug 2022 18:31:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Seth Forshee <sforshee@kernel.org>
Subject: Bug in ima_inode_setxattr()
Message-ID: <20220817163152.g3ejdtzmp5df6m2x@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hey Mimi, 
Heim Roberto
Hey everyone,

I'm currently reworking posix acls - well trying to - and so I'm also
looking at various security hooks. Currently I'm looking at
security_inode_setxattr() which calls ima_inode_setxattr() and I think
it's doing strange things when system.posix_acl_{access,deafult} is
passed as xattr. So we have:

ima_inode_setxattr(system.posix_acl_{access,default})
-> ima_protect_xattr(system.posix_acl_{access,default})
   -> evm_revalidate_status(system.posix_acl_{access,default})
   -> validate_hash_algo(system.posix_acl_{access,default}))

Since this isn't an ima_protect_xattr() it will return 0. But
evm_revalidate_status() will return true for posix acls as they seem to
be included. In any case, this will cause validate_hash_algo() to run:

So the posix acl value is cast to a struct evm_ima_xattr_data:

        const struct evm_ima_xattr_data *xvalue = xattr_value;

then passed to:

        validate_hash_algo(struct dentry *dentry, const struct evm_ima_xattr_data *xattr_value, size_t xattr_value_len)

which then passes it to:

        enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value, int xattr_len)

which does:

        switch (xattr_value->type) {
        case IMA_VERITY_DIGSIG:
                sig = (typeof(sig))xattr_value;
                if (sig->version != 3 || xattr_len <= sizeof(*sig) ||
                    sig->hash_algo >= HASH_ALGO__LAST)
                        return ima_hash_algo;
                return sig->hash_algo;
        case EVM_IMA_XATTR_DIGSIG:
                sig = (typeof(sig))xattr_value;
                if (sig->version != 2 || xattr_len <= sizeof(*sig)
                    || sig->hash_algo >= HASH_ALGO__LAST)
                        return ima_hash_algo;
                return sig->hash_algo;
        case IMA_XATTR_DIGEST_NG:
                /* first byte contains algorithm id */
                ret = xattr_value->data[0];
                if (ret < HASH_ALGO__LAST)
                        return ret;
                break;
        case IMA_XATTR_DIGEST:
                /* this is for backward compatibility */
                if (xattr_len == 21) {
                        unsigned int zero = 0;
                        if (!memcmp(&xattr_value->data[16], &zero, 4))
                                return HASH_ALGO_MD5;
                        else
                                return HASH_ALGO_SHA1;
                } else if (xattr_len == 17)
                        return HASH_ALGO_MD5;
                break;
        }

unless I have a fundamental misunderstanding this can't possibly be
right as you're casting a posix acl value to a struct
evm_ima_xattr_data and then try to retrieve

Explaining my findings to Seth (Cced) he found that it got introduced by
50f742dd9147 "IMA: block writes of the security.ima xattr with unsupported algorithms"

Could you please fix this in ima_inode_setxattr() and please in a way
that you never operate on raw posix acl values? I really would like to
prevent further integrity assumptions about posix acls; I know evm
already has some but let's not get ima involved in them as well...

(They are a pain to deal with and they represent very much structured
binary data with {g,u}ids stored in them that need to be handled in the
VFS layer.)

Christian
