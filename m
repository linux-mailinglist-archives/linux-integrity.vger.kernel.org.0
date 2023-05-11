Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763AD6FEDAF
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 10:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjEKIPJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 04:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjEKIPH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 04:15:07 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E4E2D48
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:15:05 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-44fb148ccbcso2992621e0c.0
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683792904; x=1686384904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8J5AyuQb7KXDhIq7T1eUiZkECmH3AgrEkNzwG7/4Y1k=;
        b=KgCLnWvpzk8wO6112cUpK908N2b+S2E470158cKhpD6VK5oDTWwT6KWU0jTB0folPt
         iefqzxmp4BSYgHduOrq7Mn2L0x28DVzikB/uPlCqj4ljkyp9RKAItujtQKjQZIfJfcC8
         nlAz1+6W8yIlBmOA+It7lENXJGIzxJp8KFQ7kGa8hbnrLfmbeO9B8plIqtxs4Vg8M0kA
         FKYOToPEXquxE8ApDoE0sNKif1eU0K3G9sN4WfV9NcjbwdILdqM4DFnqB7MsrGwytwFu
         GD0nvDmfY8n6CKognNQD5kbhGuCTivQlpyz3rJToYunhRewjgHsWq4OJH8CeW6Hp5NyY
         RLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683792904; x=1686384904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J5AyuQb7KXDhIq7T1eUiZkECmH3AgrEkNzwG7/4Y1k=;
        b=ODJtIrlqSFr6xedCg/NaFEBhZo9uPUa7k/0T3OtAjFryuYm5LWCAQvdVURpEqPeMEL
         jj5MHc9t8Fp8dKsLV9B227EFdKgCaREUvkg92pyOs2yc2WPqe0qtswURq4Eh7xioY88S
         CwkFAV06fyQQ8Mvm2jcQ8KpEuIss/CZftUVxdIsd8Ly6470xbk6Lhn4W2S/P2cRIWc7p
         jlJqCLlOlBUzTZasoxYb/4zECfiJCfM3fvzMWFvHklY6t/f3ktUr4S1lQKUHkVuAhMkJ
         7itN7CvblSXLO72KulllDMtHRSHNnXifgLiDiJp2a5cWW8jIJZb0AS1KmNQsWKDVQgaJ
         NCTA==
X-Gm-Message-State: AC+VfDzt66BIO2no3hE5VZrXWyp1J3VQuiP+WFRLr7LdfC606ZbsOAKJ
        Q1qHLhWIUklB/lSU4LxGyRP/E5HeJKjZ46OiYNqdVg==
X-Google-Smtp-Source: ACHHUZ6BxV1B86vSq3Yaj66p+bAKChbLmh2xv+IMsMDwd3lqyIymRigPWyvZpvqRTFmQrGtuECPvbklOmWTORlcon7g=
X-Received: by 2002:a1f:bfd2:0:b0:43f:9aaf:b629 with SMTP id
 p201-20020a1fbfd2000000b0043f9aafb629mr5416392vkf.0.1683792904155; Thu, 11
 May 2023 01:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
 <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero> <CAN5uoS8xB7=Ohu4WEA31hGraVBcaOmRxZw9PDtXBLGUMUeB=4Q@mail.gmail.com>
 <CAN5uoS9UTc-Lz1+k=-7nifuv8MrRmZh_1ck3-DgwRSF58EwpxQ@mail.gmail.com>
In-Reply-To: <CAN5uoS9UTc-Lz1+k=-7nifuv8MrRmZh_1ck3-DgwRSF58EwpxQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 11 May 2023 13:44:53 +0530
Message-ID: <CAFA6WYMf+ppAtyT5aivfq1KOEhz4MVG6godqdRhQVd0ORkb7VQ@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 11 May 2023 at 10:36, Etienne Carriere
<etienne.carriere@linaro.org> wrote:
>
> Dearl all,
>
> Typo in my previous post!
>
> On Thu, 11 May 2023 at 06:47, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Hello Jarkko,
> >
> > On Thu, 11 May 2023 at 00:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Fri May 5, 2023 at 9:43 PM EEST, Etienne Carriere wrote:
> > > > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > > > identifier rather than public login. This is needed in case fTPM service
> > > > it denied to user land application and restricted to kernel operating
> > > > system services only.
> > > >
> > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > >
> > >
> > > Can you bring up a little context here?
> > >
> > > What is REE login?
> > > Does it break backwards compatibility to switch?
> > > What kind of scenario we are talking about? What does it mean in plain
> > > English when fTPM service is denied.
> > > What is fTPM service?
> >
> > By fTPM service I meant the services exposed by fTPM through its
> > OP-TEE interface, that are the commands a client can invoke in fTPM,
> > see [1].
> >
> > Regarding backward compatibility, this change is backward compatible
> > as far as the OP-TEE entity this driver communicates with is of
> > revision 3.9.0 or above.
> > I understand this case should be addressed in some way.
> >
> > In current implementation, fTPM can be invoked by Linux kernel drivers
> > (through Linux kernel tee API as tpm_ftpm_tee currently does) as well
> > as by userland application (through TEE client library API [2]).
> > This change makes tpm_ftpm_tee to invoke fTPM interface using a client
> > identifier stating it is the Linux kernel that invokes it, not a
> > userland application. fTPM implementation does not check the client
> > identity when a client opens a session toward it. Therefore using a
> > public identifier (TEE_IOCTL_LOGIN_PUBLIC) or the OS privilege
> > identifier (TEE_IOCTL_LOGIN_REE_KERNEL) does not matter, as far as
> > OP-TEE supports these IDs. The former is native to OP-TEE initial UAPI
> > [3], the latter was introduced in OP-TEE 3.9.0 [4] and Linux kernel
> > v5.8 [5].
> >
> > That said, this change does fix an existing issue in fTPM integration.
>
> Typo, sorry, I meant
> "That said, this change does **NOT** fix an existing issue in fTPM integration."
>
> BR,
> Etienne
>
> > The fTPM entity currently only accepts a single session opened towards
> > it. This is enforced as fTPM sets property TA_FLAG_SINGLE_INSTANCE and
> > does not set property TA_FLAG_MULTI_SESSION [6].
> > Linux kernel tpm_ftpm_tee driver currently opens a session to fTPM at
> > probe time and releases it at remove time so once the driver is
> > successfully probed, no userland application can use TEE userland
> > client API to open another session and communicate with fTPM.

How about if the fTPM TEE kernel driver is built as a module and
removed at runtime by a malicious user-space client?

-Sumit

> >
> > [1] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c#L456
> > [2] https://github.com/OP-TEE/optee_client
> > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=967c9cca2cc50569efc65945325c173cecba83bd
> > [4] https://github.com/OP-TEE/optee_os/commit/78f462f646e7c037bea13aa6282c81f255922a4f
> > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=104edb94cc4b3101bab33161cd861de13e85610b
> > [6] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h#L47
> >
> > Regards,
> > Etienne
> >
> > >
> > > > ---
> > > >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > > > index 528f35b14fb6..6d32e260af43 100644
> > > > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > > > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > > > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> > > >       /* Open a session with fTPM TA */
> > > >       memset(&sess_arg, 0, sizeof(sess_arg));
> > > >       export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > > > -     sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > > > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> > > >       sess_arg.num_params = 0;
> > > >
> > > >       rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > > > --
> > > > 2.25.1
> > >
> > > BR, Jarkko
