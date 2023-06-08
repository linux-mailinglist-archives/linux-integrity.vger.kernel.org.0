Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A2C72878C
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFHS7y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 14:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbjFHS7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 14:59:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCD2717;
        Thu,  8 Jun 2023 11:59:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974AE6507C;
        Thu,  8 Jun 2023 18:59:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B23C433D2;
        Thu,  8 Jun 2023 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686250791;
        bh=rqZ4ygu1jLFkMHAxHH0SRmGgcjM3Ci1aIw0aCx2SYxI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=sfU9IXPot4mF1XN/tYoJwE16kEfPWP/tgtjkkMvyfamC9RFns57b2pY6GXZHyMj8q
         wCWSu8nyxPTAoeY6Y26DBqMn2HXnFJqppEzcVZcKw7yKn0+WFirJuyh+LrfySFQ4Fp
         +01N29WGY5G68pgZlHUFZBuWZCMQIYZWBcLa95vHipj8Dm4ez7Lh+5XXYwFmSheh+Q
         COwRgyTerjCd0MZV+YsuSzO4JTbNX56XcGwgbp7Yk0jIFBHNIlsjTBf6T9ORr8UmO2
         HL+hM+7KCL4ZuI/H7J/oc4+KKnxp38qiSNKFaK8UuhsgpJ6BpVN8y7QrPjhOycA3xJ
         tlBwaY/RqsRLw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 08 Jun 2023 21:59:46 +0300
Message-Id: <CT7I0L9VA43U.295DG4TZ6ZIC9@suppilovahvero>
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     "Jason Gunthorpe" <jgg@nvidia.com>,
        "Alejandro Cabrera" <alejandro.cabreraaldaya@tuni.fi>,
        "Jarkko Sakkinen" <jarkko.sakkinen@tuni.fi>,
        <stable@vger.kernel.org>,
        "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230530205001.1302975-1-jarkko@kernel.org>
 <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
 <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
 <0438f5e3-ca42-343b-e79e-5f7976ec8a62@linux.ibm.com>
 <CT7AOKF4OGHA.2S5VUEAG76GYB@suppilovahvero>
 <666b8422-3e4f-3d88-1ff7-1f650dd401ce@linux.ibm.com>
In-Reply-To: <666b8422-3e4f-3d88-1ff7-1f650dd401ce@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jun 8, 2023 at 6:10 PM EEST, Stefan Berger wrote:
>
>
> On 6/8/23 09:14, Jarkko Sakkinen wrote:
> > On Wed May 31, 2023 at 8:01 PM EEST, Stefan Berger wrote:
> >>
> >>
> >
> >>
> >> This is swtpm picking up this command with its user buffer.
> >>
> >>     So, I am not sure at this point what is wrong.
> >>
> >>      Stefan
> >=20
> > The answer was below but in short it is that you have a function that
> > expects __user * and you don't pass user tagged memory.
>
> There are two functions that expect user tagged memory:
>
> static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
> 				    size_t count, loff_t *off)
> static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user=
 *buf,
> 				     size_t count, loff_t *off)
>
> the correspond to this interface:
>
> struct file_operations {
> 	struct module *owner;
> 	loff_t (*llseek) (struct file *, loff_t, int);
> 	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
> 	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
>
> defined here:
>
> static const struct file_operations vtpm_proxy_fops =3D {
> 	.owner =3D THIS_MODULE,
> 	.llseek =3D no_llseek,
> 	.read =3D vtpm_proxy_fops_read,
> 	.write =3D vtpm_proxy_fops_write,
>
> Conversely, I see no other function interfaces in tpm_vtpm_proxy.c where =
the code would be missing the __user.
>
> Neither do I see any functions where I am passing a __user tagged buffer =
as parameter that shouldn't have
> such a tag on it or the reverse where a plain buffer is passed and it sho=
uld be a __user tagged buffer.

Uh oh, you're correct. I was looking this in the context of my user
vtpm driver changes, so that confused me, so it is actually my bad.
So blame is on my side.

I would still want to open code the whole thing because there is no
need to cycle it through tpm_transmit_cmd() but I'll do it in the
context of other changes.

It is pretty complicated sequence and makes hard to build anything
on top of existing functionality, so it needs to be simplified in
any case... But you are right: it is not a bug.

BR, Jarkko
