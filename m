Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87FA4AE8FE
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Feb 2022 06:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiBIFQs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Feb 2022 00:16:48 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377857AbiBIEn3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 23:43:29 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4CEC061577;
        Tue,  8 Feb 2022 20:43:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JtnLt20kgz4xcp;
        Wed,  9 Feb 2022 15:43:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1644381801;
        bh=h1IrtofJGjl9dOe2iPaZfbAAnbqY/viWBgGDEdVXQKk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X4BI56kfUn4imVm/I1LyMZe7f9s76Evbv0Pjn7HGfFFK68KUGaoCPH04q/DPmVU9g
         wR4AbQ/owkq/8kQKt0JOU1uOB+WagWSG+QKJIV7XEnJTJKHhDsign/9EnXKGREu9LK
         sVbaWMzAYonS1AI1YnbRd/ekzycbGZFh2GxEaCv7HdATX0qxEWn6/9yo6zI5z+ThBf
         qQNmyglbl+FwhdR/8QyKUyZtPKN+6fK5Fi+e9xdsGsINyiETC8A4Vxoz9lcnCcyeuM
         lrxTnV9IQhCQyG7h2V2xQJmSWs+HKYmIU+sBC2hGE8wYyYkl6AWMsv2I0fSlvW1rKx
         y/TGj1iyy/dTg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
In-Reply-To: <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
References: <cover.1641900831.git.msuchanek@suse.de>
 <d95f7c6865bcad5ee37dcbec240e79aa742f5e1d.1641900831.git.msuchanek@suse.de>
Date:   Wed, 09 Feb 2022 15:43:17 +1100
Message-ID: <87sfsslkey.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:
> Copy the code from s390x
>
> Both powerpc and s390x use appended signature format (as opposed to EFI
> based patforms using PE format).
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v3: - Philipp Rudo <prudo@redhat.com>: Update the comit message with
>       explanation why the s390 code is usable on powerpc.
>     - Include correct header for mod_check_sig
>     - Nayna <nayna@linux.vnet.ibm.com>: Mention additional IMA features
>       in kconfig text
> ---
>  arch/powerpc/Kconfig        | 16 ++++++++++++++++
>  arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)

I haven't tested this on powerpc, but assuming you have Michal this
looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
