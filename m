Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2A6FEAE8
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 06:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjEKEro (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 00:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbjEKErn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 00:47:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4971430EC
        for <linux-integrity@vger.kernel.org>; Wed, 10 May 2023 21:47:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96622bca286so1087308266b.1
        for <linux-integrity@vger.kernel.org>; Wed, 10 May 2023 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683780461; x=1686372461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SpKiDZaGDVU0u6jFIDVSu/tBRSYpbnK0i30RZbgZTo4=;
        b=IENuAtqnlIT5k0CsnQMy5aEFIKg3RBREYpd8oMKb32sWAUL/9II95Q8oIAHSYRBS1g
         i0ORWTiyc6/IJRr8+f0iDvEipXxC2GSt5UdQOnJm580ueeN45tPLCtoPokjt5q1dgkVu
         GZKkGwzanoX11yg8Qnfc5TJPZ1jg81sEQu/NMmvwWJVIp1/7Ri4a9aMOci4n9v+YnuYc
         IM5DF38oYtoUOxl4j49s/2jPF/wbii1GgcUxbFgKihoQZQN4VAcGUbCIwhzJN3HDJ6No
         1CopiAxGYXchIjPfGx4Hdg+gTfaFRnBAth6jQB5XgsN2wR2u0hBbIoN16qa+TH9zpwxh
         Y9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683780461; x=1686372461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpKiDZaGDVU0u6jFIDVSu/tBRSYpbnK0i30RZbgZTo4=;
        b=QOrSHOQWg9h3aW0LPaJ7rGjzOod6Gjxswbp83WdE26aWkyStUd62qE9hznpr17cwaN
         eOsxWk403ChOQtKKtpWEFHicpVvecdnGLjcdGx6ou6mM/kBy/LxTfxsZCLIgDSUnC7ln
         eRiWcO2KeMkIdFqbRT0Atef4gMxqNRmsvZGiKtPAWgoPlbMy64NRfgCS6FsY9C9TwggZ
         tpzQSHM2N8qYsQCTBGUQJbWaLDcQTHJg1Mx55on5247eHIH4athXiAChcumsGCA6jA24
         DulGPP7g/tfaCQPSaB04SkkFmXPENkg9KNM8TniMgwj7AmCjZ1ebJij2QcHjlSkB4QM+
         382A==
X-Gm-Message-State: AC+VfDz/LEcqKiLJ59CLgYkOg2biCBzgbx9YLG5toiaiwNzHao+jljad
        w8O8LbAX6WsDONfPZNhYC7+mF9Nsnu/8wgzecx0J9sFvJqKxsOoXCvA=
X-Google-Smtp-Source: ACHHUZ4+KncnyMkdUdPJAFlna/46h+qbYddWwSnX3zfCnI0yXV+Y4Yc53kTKrINYM2mNVrf8DXEgtBKDP/RaA+S2qAA=
X-Received: by 2002:a17:906:ee82:b0:94f:1a23:2f1c with SMTP id
 wt2-20020a170906ee8200b0094f1a232f1cmr16641052ejb.50.1683780460684; Wed, 10
 May 2023 21:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230505184318.1355446-1-etienne.carriere@linaro.org> <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero>
In-Reply-To: <CSIXYHYSW45R.O3II0HIIHZV4@suppilovahvero>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 11 May 2023 06:47:29 +0200
Message-ID: <CAN5uoS8xB7=Ohu4WEA31hGraVBcaOmRxZw9PDtXBLGUMUeB=4Q@mail.gmail.com>
Subject: Re: [PATCH] char: tpm: ftpm_tee: use kernel login identifier
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jarkko,

On Thu, 11 May 2023 at 00:12, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri May 5, 2023 at 9:43 PM EEST, Etienne Carriere wrote:
> > Changes fTPM TEE driver to open the TEE session with REE kernel login
> > identifier rather than public login. This is needed in case fTPM service
> > it denied to user land application and restricted to kernel operating
> > system services only.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
>
>
> Can you bring up a little context here?
>
> What is REE login?
> Does it break backwards compatibility to switch?
> What kind of scenario we are talking about? What does it mean in plain
> English when fTPM service is denied.
> What is fTPM service?

By fTPM service I meant the services exposed by fTPM through its
OP-TEE interface, that are the commands a client can invoke in fTPM,
see [1].

Regarding backward compatibility, this change is backward compatible
as far as the OP-TEE entity this driver communicates with is of
revision 3.9.0 or above.
I understand this case should be addressed in some way.

In current implementation, fTPM can be invoked by Linux kernel drivers
(through Linux kernel tee API as tpm_ftpm_tee currently does) as well
as by userland application (through TEE client library API [2]).
This change makes tpm_ftpm_tee to invoke fTPM interface using a client
identifier stating it is the Linux kernel that invokes it, not a
userland application. fTPM implementation does not check the client
identity when a client opens a session toward it. Therefore using a
public identifier (TEE_IOCTL_LOGIN_PUBLIC) or the OS privilege
identifier (TEE_IOCTL_LOGIN_REE_KERNEL) does not matter, as far as
OP-TEE supports these IDs. The former is native to OP-TEE initial UAPI
[3], the latter was introduced in OP-TEE 3.9.0 [4] and Linux kernel
v5.8 [5].

That said, this change does fix an existing issue in fTPM integration.
The fTPM entity currently only accepts a single session opened towards
it. This is enforced as fTPM sets property TA_FLAG_SINGLE_INSTANCE and
does not set property TA_FLAG_MULTI_SESSION [6].
Linux kernel tpm_ftpm_tee driver currently opens a session to fTPM at
probe time and releases it at remove time so once the driver is
successfully probed, no userland application can use TEE userland
client API to open another session and communicate with fTPM.

[1] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/fTPM.c#L456
[2] https://github.com/OP-TEE/optee_client
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=967c9cca2cc50569efc65945325c173cecba83bd
[4] https://github.com/OP-TEE/optee_os/commit/78f462f646e7c037bea13aa6282c81f255922a4f
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=104edb94cc4b3101bab33161cd861de13e85610b
[6] https://github.com/microsoft/ms-tpm-20-ref/blob/main/Samples/ARM32-FirmwareTPM/optee_ta/fTPM/user_ta_header_defines.h#L47

Regards,
Etienne

>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 528f35b14fb6..6d32e260af43 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -241,7 +241,7 @@ static int ftpm_tee_probe(struct device *dev)
> >       /* Open a session with fTPM TA */
> >       memset(&sess_arg, 0, sizeof(sess_arg));
> >       export_uuid(sess_arg.uuid, &ftpm_ta_uuid);
> > -     sess_arg.clnt_login = TEE_IOCTL_LOGIN_PUBLIC;
> > +     sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
> >       sess_arg.num_params = 0;
> >
> >       rc = tee_client_open_session(pvt_data->ctx, &sess_arg, NULL);
> > --
> > 2.25.1
>
> BR, Jarkko
