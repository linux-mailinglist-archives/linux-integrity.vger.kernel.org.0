Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D85351FB42
	for <lists+linux-integrity@lfdr.de>; Mon,  9 May 2022 13:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiEIL3e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 May 2022 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiEIL32 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 May 2022 07:29:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08F37BDF;
        Mon,  9 May 2022 04:25:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-046-114-032-253.46.114.pool.telefonica.de [46.114.32.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49FBB1EC0101;
        Mon,  9 May 2022 13:25:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652095527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnzmrAR2ZUBK8Gm9oPRglKuztGgYRqpvN1vVYcF44y0=;
        b=IxgWjJ1N4/q8fKohCRNTsvWIwRD8oPZvud9IZ0CCOp85pHjw8qDU0JKx41U8kI61H2avA2
        wMcvVLXAsJ997LNdhXKNdSxtYhs0OpJjJeF3g8nKHeuBxw5mNJjms6I8JZenyUUkCcqTGM
        dmB1ysxPIu7k4qKuNmbHZGqahUCVn38=
Date:   Mon, 09 May 2022 11:25:22 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
User-Agent: K-9 Mail for Android
In-Reply-To: <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG> <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG> <YnjvfNs5pgWiomWx@noodles-fedora.dhcp.thefacebook.com>
Message-ID: <0960C132-581C-4881-8948-C566657C3998@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On May 9, 2022 10:40:01 AM UTC, Jonathan McDowell <noodles@fb=2Ecom> wrote:
>> powerpc and ARM64 both achieve this using device tree with a
>> "linux,ima-kexec-buffer" node=2E x86 platforms generally don't make use=
 of
>> device tree

What's wrong with making x86 use the same devicetree node(s)?

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
