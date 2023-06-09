Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD27290E5
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 09:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbjFIH0L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjFIH0K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 03:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F9172E;
        Fri,  9 Jun 2023 00:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E7163C13;
        Fri,  9 Jun 2023 07:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51386C433D2;
        Fri,  9 Jun 2023 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686295568;
        bh=NlICh2LYArFyyDIk04t30ruq6pjEc3ONIT3pYa7ypiE=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ANDEU18q7UCQthZ5DblcmPaYvHtJjKsbfDRJ4Gr6/G31wRvhwnoTLJzzIWxl47r/j
         kPn7htSOVJOBpOc4yiPiPcC8y4Q1CzBD0AaOE2hXSaRHsgB57mkjrZeokIl85SQAPu
         AVPSwu6LVC1i4P0X/gbbbWPBISznHGxT3Sfs33t4JTKau50ZW8ioGwdn0wS50X2zum
         AoWJwi/GMjuhQz+Un/SxO8pBGVXo5qv8vv3P60BVSeP1MXYUa36A3vdiui7eDYoR3o
         zcKO5Tgp+I8IHqZux4ubthpYpn1E4wZPqD21HDlAG4tNTTWiTE8/GVZNXiep+9Hxkf
         qVVYEE3872LqA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 09 Jun 2023 10:26:00 +0300
Message-Id: <CT7XVY50ISCC.1I60H7POH94ES@suppilovahvero>
Cc:     <miklos@szeredi.hu>, <linux-unionfs@vger.kernel.org>,
        <kamatam@amazon.com>, <yoonjaeh@amazon.com>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <stephen.smalley.work@gmail.com>, <eparis@parisplace.org>,
        <casey@schaufler-ca.com>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <selinux@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kpsingh@kernel.org>,
        <keescook@chromium.org>, <nicolas.bouchinet@clip-os.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        "Mengchi Cheng" <mengcc@amazon.com>
X-Mailer: aerc 0.14.0
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
 <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
In-Reply-To: <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon Jun 5, 2023 at 11:38 AM EEST, Roberto Sassu wrote:
> On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > With the newly added ability of LSMs to supply multiple xattrs, set
> > SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiat=
e().

nit: TRANSMUTE

Sorry, just hit into my eye. I skimmed it because I implemented original
feature :-)

BR, Jarkko

