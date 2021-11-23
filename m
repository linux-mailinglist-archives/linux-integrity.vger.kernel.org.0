Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7AD459D90
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Nov 2021 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbhKWIQn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Nov 2021 03:16:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233988AbhKWIQn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Nov 2021 03:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637655214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3Btiz5nwMWKzC0W/eHifXll2VpJykh1k99oSwAlKTw=;
        b=ZPdPoO9wbXGS2YPdEKxL/da0oILk7ukj+UqNADQe/K+7XBfG+ojTSWlvL9P2+bGw+qofuj
        amHTZCZU/z1ni+6MqUYLNRWlZDFvnjNUB+QqRPRwJV3n9fx89JlEGvhHAlt9z3RQFHjBtt
        Mz8BZZdfAvnnk5CR+LwIJf15+S18OjA=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-429-WAlUv4_uOEaFfYy6cCcaYQ-1; Tue, 23 Nov 2021 03:13:33 -0500
X-MC-Unique: WAlUv4_uOEaFfYy6cCcaYQ-1
Received: by mail-pg1-f197.google.com with SMTP id h2-20020a632102000000b003210bade52bso2077963pgh.9
        for <linux-integrity@vger.kernel.org>; Tue, 23 Nov 2021 00:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O3Btiz5nwMWKzC0W/eHifXll2VpJykh1k99oSwAlKTw=;
        b=A/G36om5SY+C5OJtq2M4RbsNpIVBvcNJwenvmiKOqbKYSkFBtktUwHYlZ+nYIM241Z
         2g6SCu4yTCTNLSOxkRD3QyTYdZc2DpTqBEdnBuYllm2RyVMagF54206B/FAxOkrpE4Ut
         qidWB8TirUIJmfTFVPjJ2Jmf2V4crnKaJe+Aq60j87Re1Rtrz7hit+upapAVVeRYfeHY
         kOnqAauqvasPavw2pj/kY0vKOPF7wz0r0IvojGFyf3kv4VU4TknJw1NsFHEffbKddKLP
         BqBoT7wid01NCRgq1sjIZIuDcAiLzkuzEKgnXTKGDN399horOLfVvPABuTitrqPXJvXr
         ZLcg==
X-Gm-Message-State: AOAM532DQMzgfgf0PMr7FhNw1pW8Yc15cJtl9EFsLosb2qDpnydGDd6U
        i0wyqdhvsappAixSkOg30E77dB/Vob4KrHTf4s19SAJozXt6TzL1f3pNrMtpgVc1kCV/ZUbwUU3
        /L14kRmmXWjqstSiyym9kL7+dNYhW3VIRlxz+E57w5Tek
X-Received: by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP id o23-20020a170902779700b0014388c37ff1mr4598433pll.22.1637655212434;
        Tue, 23 Nov 2021 00:13:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzp1wBdneu0emdkOY1J3COTZHl45URmatSlfOmb+lu2/bMIFBrPujjaaeKFXgb43G7YzJiJ3bucNsc9n8IUXCo=
X-Received: by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP id
 o23-20020a170902779700b0014388c37ff1mr4598401pll.22.1637655212162; Tue, 23
 Nov 2021 00:13:32 -0800 (PST)
MIME-Version: 1.0
References: <20211122191752.1308953-1-stefanb@linux.ibm.com> <20211122191752.1308953-2-stefanb@linux.ibm.com>
In-Reply-To: <20211122191752.1308953-2-stefanb@linux.ibm.com>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Tue, 23 Nov 2021 12:13:21 +0400
Message-ID: <CAMxuvay+TJ8fs50GoZXUkX5NUsq20+xQBY3W5OSxMMvVGhJNow@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: tpm: Probe for available PCR bank
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jarkko@kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 22, 2021 at 11:18 PM Stefan Berger <stefanb@linux.ibm.com> wrot=
e:
>
> Probe for an available PCR bank to accommodate devices that do not have a
> SHA-1 PCR bank or whose SHA-1 bank is deactivated.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  tools/testing/selftests/tpm2/tpm2_tests.py | 31 ++++++++++++++++------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/s=
elftests/tpm2/tpm2_tests.py
> index 9d764306887b..a569c8d0db08 100644
> --- a/tools/testing/selftests/tpm2/tpm2_tests.py
> +++ b/tools/testing/selftests/tpm2/tpm2_tests.py
> @@ -27,7 +27,21 @@ class SmokeTest(unittest.TestCase):
>          result =3D self.client.unseal(self.root_key, blob, auth, None)
>          self.assertEqual(data, result)
>
> +    def determine_bank_alg(self):
> +        # Probe for available PCR bank
> +        for bank_alg in [tpm2.TPM2_ALG_SHA1, tpm2.TPM2_ALG_SHA256]:
> +            try:
> +                handle =3D self.client.start_auth_session(tpm2.TPM2_SE_T=
RIAL)
> +                self.client.policy_pcr(handle, [17], bank_alg=3Dbank_alg=
)
> +                break
> +            except tpm2.UnknownPCRBankError:
> +                pass
> +            finally:
> +                self.client.flush_context(handle)
> +        return bank_alg
> +
>      def test_seal_with_policy(self):
> +        bank_alg =3D self.determine_bank_alg()
>          handle =3D self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>
>          data =3D ('X' * 64).encode()
> @@ -35,7 +49,7 @@ class SmokeTest(unittest.TestCase):
>          pcrs =3D [16]
>
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=3Dbank_alg)
>              self.client.policy_password(handle)
>
>              policy_dig =3D self.client.get_policy_digest(handle)
> @@ -47,7 +61,7 @@ class SmokeTest(unittest.TestCase):
>          handle =3D self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=3Dbank_alg)
>              self.client.policy_password(handle)
>
>              result =3D self.client.unseal(self.root_key, blob, auth, han=
dle)
> @@ -72,6 +86,7 @@ class SmokeTest(unittest.TestCase):
>          self.assertEqual(rc, tpm2.TPM2_RC_AUTH_FAIL)
>
>      def test_unseal_with_wrong_policy(self):
> +        bank_alg =3D self.determine_bank_alg()
>          handle =3D self.client.start_auth_session(tpm2.TPM2_SE_TRIAL)
>
>          data =3D ('X' * 64).encode()
> @@ -79,7 +94,7 @@ class SmokeTest(unittest.TestCase):
>          pcrs =3D [16]
>
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=3Dbank_alg)
>              self.client.policy_password(handle)
>
>              policy_dig =3D self.client.get_policy_digest(handle)
> @@ -91,13 +106,13 @@ class SmokeTest(unittest.TestCase):
>          # Extend first a PCR that is not part of the policy and try to u=
nseal.
>          # This should succeed.
>
> -        ds =3D tpm2.get_digest_size(tpm2.TPM2_ALG_SHA1)
> -        self.client.extend_pcr(1, ('X' * ds).encode())
> +        ds =3D tpm2.get_digest_size(bank_alg)
> +        self.client.extend_pcr(1, ('X' * ds).encode(), bank_alg=3Dbank_a=
lg)
>
>          handle =3D self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=3Dbank_alg)
>              self.client.policy_password(handle)
>
>              result =3D self.client.unseal(self.root_key, blob, auth, han=
dle)
> @@ -109,14 +124,14 @@ class SmokeTest(unittest.TestCase):
>
>          # Then, extend a PCR that is part of the policy and try to unsea=
l.
>          # This should fail.
> -        self.client.extend_pcr(16, ('X' * ds).encode())
> +        self.client.extend_pcr(16, ('X' * ds).encode(), bank_alg=3Dbank_=
alg)
>
>          handle =3D self.client.start_auth_session(tpm2.TPM2_SE_POLICY)
>
>          rc =3D 0
>
>          try:
> -            self.client.policy_pcr(handle, pcrs)
> +            self.client.policy_pcr(handle, pcrs, bank_alg=3Dbank_alg)
>              self.client.policy_password(handle)
>
>              result =3D self.client.unseal(self.root_key, blob, auth, han=
dle)
> --
> 2.31.1
>

