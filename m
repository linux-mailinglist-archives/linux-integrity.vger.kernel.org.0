Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAC5A2DC2
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Aug 2022 19:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245347AbiHZRnV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Aug 2022 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiHZRnU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Aug 2022 13:43:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6CC3F42;
        Fri, 26 Aug 2022 10:43:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id cu2so4545650ejb.0;
        Fri, 26 Aug 2022 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=NCMaVbRVmfzCQC//soO0cPljODJ/kKcr4ft4UHsvOWE=;
        b=D+cVRFCihGfyTm7tL9oaZiCCLpiQIndFkS1M1FgD8jGc4ETdJT4uBi13nLsMg+0mtf
         t7VQWPmHl0lg28LNdO/hp9hpfAEZr811oIiGkGtZ2FDGwn9gHoS0XbmIYQD4uCrLjplC
         2S04x1OTUcASEd6rOC6E99bfMvZ17psP8tM6OUEJCD80PJRNc/pXHHDWSu87nnS/5YuP
         70S0j8Qg4NQeeCoAdF1h/PaB3MgKjrygTthllbUqxekQCVtpWH+mUjxFEqTkdT6WvuKE
         EiK/ATHFS55nfSSBqlThOurRGU+3A4XlL4tzOXohJSrHYAMwV6Nm02MiciwiZt6EdYqp
         FwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=NCMaVbRVmfzCQC//soO0cPljODJ/kKcr4ft4UHsvOWE=;
        b=eJZGuCfC55rsz0nPS3FPt1Un5uZpv1KZPMPUi252nm88K/xY41l7T9qp5ORBHgMvZm
         7sIy2KVWj4PPm244OXSJlnV01oYofT7DmuEzrECP0DDb5Tx/am1crpm7otyUv2miZE5l
         1bym2yt9geaXj69hzA+h0SJHqZq5vFIViGf482g9iOu2OMtEe64rgUxLQEtaByPXKt9M
         Xt+NcZIhZeqgoBlzFKlHrtLZD9GMgrC0/ppYmtPwxRunOn3dotueFhOZngeyzCT2psSM
         o6bA42o4HwBPYxVpnRx/YmTiA66OXqzDwF++rlcv5FlTytJPS+zTyXiJgTRtzUuQxE35
         u6Aw==
X-Gm-Message-State: ACgBeo0FLkA2/scSs0GGQMN7LeQzFHlB9QtEPn50QZ+Fq8qXJ8fTjNsq
        h1UAXdZUnKm3LyW78807XcngQMeof5zFIL04NXU=
X-Google-Smtp-Source: AA6agR7YT/Vzflbb/eQcVXHa6RXZd/+OntqiK6j/PVKq/tv/mkZb37gh+WaL4S3Dv28l0BcbSH4nIf4eX7sYx1y9WZQ=
X-Received: by 2002:a17:907:970e:b0:731:4fb4:5f7b with SMTP id
 jg14-20020a170907970e00b007314fb45f7bmr6045348ejc.556.1661535798494; Fri, 26
 Aug 2022 10:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de> <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
In-Reply-To: <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 26 Aug 2022 13:43:07 -0400
Message-ID: <CAKf6xpsc9KRUKo5Z-kPqDcSCdpf9-tjf+ZdREnEiJUdHwyDQcA@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] tpm, tpm_tis: Only handle supported interrupts
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 29, 2022 at 7:28 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wro=
te:

> @@ -1007,8 +1029,39 @@ int tpm_tis_core_init(struct device *dev, struct t=
pm_tis_data *priv, int irq,
>         if (rc < 0)
>                 goto out_err;
>
> -       intmask |=3D TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_IN=
T |
> -                  TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> +       /* Figure out the capabilities */
> +       rc =3D tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfc=
aps);
> +       if (rc < 0)
> +               goto out_err;
> +
> +       dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> +               intfcaps);
> +       if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
> +               dev_dbg(dev, "\tBurst Count Static\n");
> +       if (intfcaps & TPM_INTF_CMD_READY_INT) {
> +               intmask |=3D TPM_INTF_CMD_READY_INT;
> +               dev_dbg(dev, "\tCommand Ready Int Support\n");
> +       }
> +       if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
> +               dev_dbg(dev, "\tInterrupt Edge Falling\n");
> +       if (intfcaps & TPM_INTF_INT_EDGE_RISING)
> +               dev_dbg(dev, "\tInterrupt Edge Rising\n");
> +       if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
> +               dev_dbg(dev, "\tInterrupt Level Low\n");
> +       if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
> +               dev_dbg(dev, "\tInterrupt Level High\n");
> +       if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)

Hi, you may already have fixed this, but I just saw:

error: this =E2=80=98if=E2=80=99 clause does not guard... [-Werror=3Dmislea=
ding-indentation]
 1144 |         if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
      |         ^~

> +               intmask |=3D TPM_INTF_LOCALITY_CHANGE_INT;
> +               dev_dbg(dev, "\tLocality Change Int Support\n");

You need { } for the block.

Regards,
Jason
