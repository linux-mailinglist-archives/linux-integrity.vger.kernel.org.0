Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786A86F09DF
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbjD0Qaq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbjD0Qap (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 12:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCE7187;
        Thu, 27 Apr 2023 09:30:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4766663E39;
        Thu, 27 Apr 2023 16:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA46EC433D2;
        Thu, 27 Apr 2023 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682613042;
        bh=OmjilNqaEg4FBJ0Amg+2m1CqZ7Mi+fj6I+FNpHYmcmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i8hf+1yM6b/03KJKZP2jvKGFi3P77LMD78cMUdNV1/e6HTudN1OhrZr3VoJbudtuk
         qN7ucUtubNkoYTOErFvGh7oCSNAPMMzlk2i/Gmu1YZIFahElV0wNVDVRBwonz5C8sb
         LrQmVwlFEHv8ZEl7Tr/9T4HwI7o6HeRiB1WQ5NRcPDe6E0J2Gl0XsvvG5xKIzWPb5P
         E5d80QrHLAtsND6tjSRjEDHuJDMcoy75ewjzImcNYkH49L/H/L4UMLkenp9CBuob2v
         EXN7/BwAqDI1q5wlPNcGdlvska/79VPmwZ0UX3iFJu8z13c2IWWP8Ts030+wiIeKGo
         ndxk0r+bDS+Hg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Apr 2023 19:30:36 +0300
Message-Id: <CS7OJHZ1JZ1C.199SDPTFJU10C@wks-101042-mac.ad.tuni.fi>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Lino Sanfilippo" <l.sanfilippo@kunbus.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1
X-Mailer: aerc 0.14.0
References: <20230427111125.13769-1-jarkko@kernel.org>
 <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
In-Reply-To: <CAHk-=wiGauUNbV_1ZdxG92aWF+oqnnqdRg4z2h-FxXjB_w3Xiw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Apr 27, 2023 at 6:38 PM EEST, Linus Torvalds wrote:
> On Thu, Apr 27, 2023 at 4:11=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > This PR fixes a critical bug in my first pull request.
>
> That doesn't work AT ALL.
>
> You have this duplicated line
>
> -       TPM_CHIP_FLAG_FIRMWARE_UPGRADE  =3D BIT(7),
> +       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
> +       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
> +       TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>
> in that patch (presumably due to some edit-time fat-fingering), which
> causes lots and lots of
>
>   ./include/linux/tpm.h:285:9: error: redeclaration of enumerator
> =E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
>     285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/tpm.h:284:9: note: previous definition of
> =E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99 with type =E2=80=98int=
=E2=80=99
>     284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ./include/linux/tpm.h:286:9: error: redeclaration of enumerator
> =E2=80=98TPM_CHIP_FLAG_FIRMWARE_UPGRADE=E2=80=99
>     286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> errors.
>
> While I could easily just remove the duplicated lines in my merge,
> that would make things non-bisectable, so I unpulled this instead.
>
>              Linus

My bad, please do not. I'll send a new one, cherry pick gone wrong :-(

BR, Jarkko
