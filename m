Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51736FEDD1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 10:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjEKIZz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjEKIZw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 04:25:52 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80310EC
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:25:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so76710651a12.1
        for <linux-integrity@vger.kernel.org>; Thu, 11 May 2023 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683793549; x=1686385549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vPthJJFX5ICybkhpQbILdoKtwUZwEEscWvDxRj2UCS8=;
        b=keCpqcazqHLQcn9JA/WC4PqRcOE6Pe0sqmS/4/0Dcr/03siOEhCWlMNowlHTtWZUw+
         SzQnZwblyTcW+PSQ1mftHjf8I9pRpTbuOGqaDNS9I2f0kuG45xx/Isd4N/NS/hMEENrE
         ++qFblLb0SYgzrolNxxWsKsbVi3pRxBx904h+iH7KDfLosemfQaRLAS8R3aR8VzjFn7q
         cFTikMVHG3kIEu33aL32wlDdy96oD/pkeck8/Mlv7UAYlbX2q12wrGbDdsXcEUM0RSwa
         U/MHxO7lRYDuYayPOqUrimnJbxsy9bJO0JHAL9khTZzlph35Fkb8+jHpAxv23nmavz+W
         4kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683793549; x=1686385549;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPthJJFX5ICybkhpQbILdoKtwUZwEEscWvDxRj2UCS8=;
        b=Axrm8yu8McBBLfCrdyYrbX376HdlVGkh6zrN7vwBE3XTcjb+/hhSSGSXsT1955SAWD
         ut7hkKBAIQJA0SO1Ble7gpk66b9dp5v5oybEgnMBdF2HTGSbITSlG7ueUj1lcFGUwfkm
         IwZAIdUGrth89z132jUayvLeq9mo2GnSYlSSLaln8kqUuOKFmFgxud8jVlsvwCSXyREg
         n+gtQYstmCEw1kIosiO+pxBZkRN+lwGf3afVOTlnLs6aIijbFl9059wcYkl+cU2azqaC
         +/NWl30AqnglEmDuRjaIvSRMdbAIGgeD69qA8MjYkugwGLFUbZaOeX3jSQKWwjOOmlcj
         2LSQ==
X-Gm-Message-State: AC+VfDwNMS2aFf/ALK/8Ikv05yr0pzcllcr6oP9dWq14XlC57zaVAY5a
        dhfqx1b3Mr196eTH2GAgeaE7ftZ3cIXcQILNDToFiw==
X-Google-Smtp-Source: ACHHUZ65ndyxPKJzTQECszjt+HbWhyCk1GsXv5AmDRtfTgWc63i5zS5teybqkPaer2P36DQDlaWI3HrLI2ALAwboHPo=
X-Received: by 2002:a17:907:7f02:b0:958:46aa:7f99 with SMTP id
 qf2-20020a1709077f0200b0095846aa7f99mr19136007ejc.7.1683793549007; Thu, 11
 May 2023 01:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org>
 <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero> <CAN5uoS8xB7=Ohu4WEA31hGraVBcaOmRxZw9PDtXBLGUMUeB=4Q@mail.gmail.com>
 <CAN5uoS9UTc-Lz1+k=-7nifuv8MrRmZh_1ck3-DgwRSF58EwpxQ@mail.gmail.com> <CAFA6WYMf+ppAtyT5aivfq1KOEhz4MVG6godqdRhQVd0ORkb7VQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMf+ppAtyT5aivfq1KOEhz4MVG6godqdRhQVd0ORkb7VQ@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 11 May 2023 10:25:38 +0200
Message-ID: <CAN5uoS8mjcPK=3x=RQ8jVFkrCL6hmxYEjd5G9PCzW7A8U=yojg@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Sumit Garg <sumit.garg@linaro.org>, thiruan@microsoft.com
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

On Thu, 11 May 2023 at 10:15, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 11 May 2023 at 10:36, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Dearl all,
> >
> > Typo in my previous post!
> >
> > On Thu, 11 May 2023 at 06:47, Etienne Carriere
> > <etienne.carriere@linaro.org> wrote:
> > >
> > > Hello Jarkko,
> > >
> > > On Thu, 11 May 2023 at 00:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Fri May 5, 2023 at 9:43 PM EEST, Etienne Carriere wrote:
> > > > > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > > > > identifier rather than public login. This is needed in case fTPM service
> > > > > it denied to user land application and restricted to kernel operating
> > > > > system services only.
> > > > >
> > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > > >
> > > >
> > > > Can you bring up a little context here?
> > > >
> > > > What is REE login?
> > > > Does it break backwards compatibility to switch?
> > > > What kind of scenario we are talking about? What does it mean in plain
> > > > English when fTPM service is denied.
> > > > What is fTPM service?
> > >
> > > By fTPM service I meant the services exposed by fTPM through its
> > > OP-TEE interface, that are the commands a client can invoke in fTPM,
> > > see [1].
> > >
> > > Regarding backward compatibility, this change is backward compatible
> > > as far as the OP-TEE entity this driver communicates with is of
> > > revision 3.9.0 or above.
> > > I understand this case should be addressed in some way.
> > >
> > > In current implementation, fTPM can be invoked by Linux kernel drivers
> > > (through Linux kernel tee API as tpm_ftpm_tee currently does) as well
> > > as by userland application (through TEE client library API [2]).
> > > This change makes tpm_ftpm_tee to invoke fTPM interface using a client
> > > identifier stating it is the Linux kernel that invokes it, not a
> > > userland application. fTPM implementation does not check the client
> > > identity when a client opens a session toward it. Therefore using a
> > > public identifier (TEE_IOCTL_LOGIN_PUBLIC) or the OS privilege
> > > identifier (TEE_IOCTL_LOGIN_REE_KERNEL) does not matter, as far as
> > > OP-TEE supports these IDs. The former is native to OP-TEE initial UAPI
> > > [3], the latter was introduced in OP-TEE 3.9.0 [4] and Linux kernel
> > > v5.8 [5].
> > >
> > > That said, this change does fix an existing issue in fTPM integration.
> >
> > Typo, sorry, I meant
> > "That said, this change does **NOT** fix an existing issue in fTPM integration."
> >
> > BR,
> > Etienne
> >
> > > The fTPM entity currently only accepts a single session opened towards
> > > it. This is enforced as fTPM sets property TA_FLAG_SINGLE_INSTANCE and
> > > does not set property TA_FLAG_MULTI_SESSION [6].
> > > Linux kernel tpm_ftpm_tee driver currently opens a session to fTPM at
> > > probe time and releases it at remove time so once the driver is
> > > successfully probed, no userland application can use TEE userland
> > > client API to open another session and communicate with fTPM.
>
> How about if the fTPM TEE kernel driver is built as a module and
> removed at runtime by a malicious user-space client?

This is why this change can help to lower the attack surface IMHO.

Note that if a malicious user manages to load a malicious module,
there is nothing OP-TEE or fTPM can do about it. I guess it is the
same situation for all tpm drivers in the Linux kernel.

etienne

>
> -Sumit
>
> > >
> > > [1] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c#L456
> > > [2] https://github.com/OP-TEE/optee_client
> > > [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=967c9cca2cc50569efc65945325c173cecba83bd
> > > [4] https://github.com/OP-TEE/optee_os/commit/78f462f646e7c037bea13aa6282c81f255922a4f
> > > [5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=104edb94cc4b3101bab33161cd861de13e85610b
> > > [6] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h#L47
> > >
> > > Regards,
> > > Etienne
> > >
> > > >
> > > > > ---
> > > > >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > > > > index 528f35b14fb6..6d32e260af43 100644
> > > > > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > > > > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > > > > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> > > > >       /* Open a session with fTPM TA */
> > > > >       memset(&sess_arg, 0, sizeof(sess_arg));
> > > > >       export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > > > > -     sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > > > > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> > > > >       sess_arg.num_params = 0;
> > > > >
> > > > >       rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > > > > --
> > > > > 2.25.1
> > > >
> > > > BR, Jarkko
