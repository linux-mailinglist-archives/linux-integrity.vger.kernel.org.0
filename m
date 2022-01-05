Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D264859D5
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 21:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbiAEUMe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 15:12:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60114 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbiAEUMd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 15:12:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F256183C;
        Wed,  5 Jan 2022 20:12:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB3DC36AE0;
        Wed,  5 Jan 2022 20:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641413552;
        bh=VKtAIConpbBFA6GqxUHN4Ht5xmPdKeItLVEssC8Va1I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Isjb6nB8batMswToanbNXUml8r8wH4WSeugz+Hr84UYHiH7dlo9tjAhZwx+ClrmeK
         ahBbeCGAqlVNrB7ke+ptPWuZ2OD2SnZdTbRrPTBiqbF9IUZikURO17wUyUjjDSlnZ3
         qsu2kITz6cxMK0ovuobEdC/TmBfFTDtWjNuV+J1HP6tSHQB6dylKSECi66sTAMb/TD
         p5muKmpGAobQUUHg38SbLzBCFIbJ0+tZ2CsFFJ865Z93mynpn7FKoDCMbbbO6ADvqI
         aP5g06Nnjx9lusr4vte/UdNcSTx6kbXekd4EcWgdBW7sOMQVtt9Bo/L+QIPxumegzG
         UWXrD0Zb+Aiog==
Message-ID: <db88a381739e08806e2370e8fbe8fdde82731464.camel@kernel.org>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>, linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Wed, 05 Jan 2022 22:12:27 +0200
In-Reply-To: <20211229215330.4134835-1-yaelt@google.com>
References: <20211229215330.4134835-1-yaelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-29 at 16:53 -0500, Yael Tiomkin wrote:
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to instantiate encrypted keys using
> user-provided decrypted data, and therefore allows to perform key
> encryption from userspace. The decrypted key material will be
> inaccessible from userspace.

The 2nd to last sentence is essentially a tautology but fails to
be even that, as you can already "perform key encryption" from user
space, just not with arbitrary key material.

It does not elighten any applications of this feature.

/Jarkko
