Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F295F7BD0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Oct 2022 18:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJGQu7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Oct 2022 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJGQu6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Oct 2022 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FB8F24C
        for <linux-integrity@vger.kernel.org>; Fri,  7 Oct 2022 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665161453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAxMQ7jaQcvS3LjIqlLB7spIGR/Xc/EwF3zs3cv4sZo=;
        b=HUBgc9I7q5RI52ys9OTp6LARe/IPZNJn4Bwt++Nr6lEC19FwQF7XUjwg+62QZ1NeO5taKm
        VzJszCROnpxuwqYJNlChzoiQQvlJ/bf2FcUCGoKNtSOw6/lSaAAwHMC95AwWnaOCUuY/Rp
        2t9hqKoUPiu8a1+mYhJkmUeTlfIW9C8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-54-qFF6xVRgNkejF71fyDyO5Q-1; Fri, 07 Oct 2022 12:50:52 -0400
X-MC-Unique: qFF6xVRgNkejF71fyDyO5Q-1
Received: by mail-oi1-f197.google.com with SMTP id s33-20020a05680820a100b0034fffd34dd7so3007464oiw.17
        for <linux-integrity@vger.kernel.org>; Fri, 07 Oct 2022 09:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uAxMQ7jaQcvS3LjIqlLB7spIGR/Xc/EwF3zs3cv4sZo=;
        b=AjUkq1jq5jE3pUqstK/Q6/ZpAeOuow0m+qnU46m0IHpOcU9zhsdBBSSVCpfgGEdu25
         cDXkuPULUqCxqLX1UwRdO/CWIinnKXdPq8QrBblDHojtRU2ToRgn+gbTOAuuAyZPesss
         QYSsG6dd475RkMW58/c2tOlsuAUDH6UWGte65jKs68WHcxOg/D/1WYRLWchPqVQLT41d
         Lv4A3PsKSiCzei3oZdOBxO6Pm6z8JaGja+xF7De/XM367xiMkG2pkB23qoor7zMRzG88
         rycaFolfBIEcCGN842h7Z7xPsLYIE/LoFJHQ7icxxQaoPiPaDNHrsYtNTlmG+i/pnBHW
         XRzw==
X-Gm-Message-State: ACrzQf2x9N3QF4+VWSb+4PB3Szfydt6yHpwOfiQVyUZpUh6aZ27WUnwn
        oVGbxtYWDZSAtB9ruqO03e28QqHBHIA+4SgTkLOpV/jMoHWhlpTS243QZUOYt6T1snJu99cGEjF
        TmSO0RsEZycu6hcbRvEJRaurGFVYvfw9T3KLqzOlDG0Rd+qfr6iHjeV4rSLxUQIuaqzuk09RrUj
        Y/zOaS
X-Received: by 2002:a05:6808:1386:b0:350:733d:b65d with SMTP id c6-20020a056808138600b00350733db65dmr7894096oiw.21.1665161451370;
        Fri, 07 Oct 2022 09:50:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM79Q7wtqSFiHpZgkOlXEx4YpWWbq4UcWrF58pWd0puj2M3cbPCCCk1ANhbQcS3s1/pCntBDig==
X-Received: by 2002:a05:6808:1386:b0:350:733d:b65d with SMTP id c6-20020a056808138600b00350733db65dmr7894083oiw.21.1665161451084;
        Fri, 07 Oct 2022 09:50:51 -0700 (PDT)
Received: from [192.168.1.35] (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id k4-20020a056870818400b001328ce69d36sm1560747oae.9.2022.10.07.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:50:50 -0700 (PDT)
Message-ID: <1d0b01793100651682413ab1e14c1b1d0e9f68f0.camel@redhat.com>
Subject: Is efi_tpm_eventlog_init calling memblock_reserve correctly for the
 TPM final log?
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Fri, 07 Oct 2022 09:50:49 -0700
In-Reply-To: <CALzcddsfNchgJhKdxbUDDb3zBhbHZfYLCtRt9o6o=pv-zk_w_g@mail.gmail.com>
References: <CALzcddsfNchgJhKdxbUDDb3zBhbHZfYLCtRt9o6o=pv-zk_w_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-06-22 at 21:26 -0700, Jerry Snitselaar wrote:
> Is this calling memblock_reserve() correctly for the final events
> log?
>=20
> For the tpm events log it does:
>=20
> memblock_reserve(efi.tpm_log, tbl_size);
>=20
> For the final events log it does:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memblock_reserve((=
unsigned long)final_tbl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tbl_size + sizeof(*final_tbl));
>=20
>=20
> which ends up with something like:
>=20
> [=C2=A0=C2=A0=C2=A0 0.000000] memblock_reserve:
> [0x000000005d7b5018-0x000000005d7b958a]
> efi_tpm_eventlog_init+0x82/0x370
> [=C2=A0=C2=A0=C2=A0 0.000000] memblock_reserve:
> [0xffffffffff2c0000-0xffffffffff2c00e4]
> efi_tpm_eventlog_init+0x324/0x370
>=20
>=20
> Regards,
> Jerry
>=20

Hi Matthew and Jarrko,

Is efi_tpm_eventlog_init() calling memblock_reserve() with the correct
argument for the TPM final log, or should it be the following instead:

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 8f665678e9e3..e8d69bd548f3 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -97,7 +97,7 @@ int __init efi_tpm_eventlog_init(void)
 		goto out_calc;
 	}
=20
-	memblock_reserve((unsigned long)final_tbl,
+	memblock_reserve(efi.tpm_final_log,
 			 tbl_size + sizeof(*final_tbl));
 	efi_tpm_final_log_size =3D tbl_size;
=20



