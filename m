Return-Path: <linux-integrity+bounces-2944-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C64A91E2D4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E501F224A6
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9216C698;
	Mon,  1 Jul 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oM/+2upB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A61607BC;
	Mon,  1 Jul 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845557; cv=none; b=nshwp3sjRfEzrkaBqE9i/PK8Rhyn6hyRJ4SP8w4+EubXCc3BfZ6gLimmhaNJ9Ii+b25IiQ3NV32XPSWP0Hho3r1afoc3zi6ceoZKeDsc1px7GDA6dAbcLXM6sUoxEmk350ZHD9QwiVBxIiV9gY1MdU9SWvVl+e40fh89RzaFKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845557; c=relaxed/simple;
	bh=p9YfnGbtHLfEIX8p3mNY3/6BkKuqCdHuCCiSXutUbIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uzxsQU81hfaEjYPmJ+KIoSDf0FvfKaUHZ1yKFl1UGO5/MXmrYJ36aaOrUmy4sKdiAAl9rb1ucuk+oX2KtUe7yH+qy90UCQsiW/QoUR1np6nc60gYYXFsacVeem5vSOqF3tougYtfIYK7aoDf57FfC1UjUcM2/RdmvjkiLy1zDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oM/+2upB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC54DC116B1;
	Mon,  1 Jul 2024 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845557;
	bh=p9YfnGbtHLfEIX8p3mNY3/6BkKuqCdHuCCiSXutUbIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=oM/+2upBDtZEj0r91Tqkmmg5mXJ6AoyvHu3pAqjHLI3lKmG2+YoGCGQS1//g2O37W
	 XYoZel02aU09rtL4WEhgzxhYNEYIT//n5qMkHITDC4ndG09KPjUbuJEKW5ngBTnkEV
	 geyPxQOC8eLbnHh8O9YllCmRf1UPK3a55VU/yuoNk/1BigWO4Nggoq06zxHdPDJQc6
	 /Doso1JNA8cO6fecnaCmDV2eFQw1GKZxwNe4rTZogBiIJhlox1swQ8Zh2fkgklSssz
	 Y4gkxxEeOtIIOfYFglBRYqgGKqov9GQ27BbRqLXrW9De1rQkbFNsa6DKduApzrWxdM
	 JBwPXzlBBKZZQ==
Message-ID: <656b319fc58683e399323b880722434467cf20f2.camel@kernel.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, 
	naveen.n.rao@linux.ibm.com
Date: Mon, 01 Jul 2024 14:52:33 +0000
In-Reply-To: <20240617193408.1234365-1-stefanb@linux.ibm.com>
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-17 at 15:34 -0400, Stefan Berger wrote:
> Fix the following type of error message caused by a missing call to
> tpm2_sessions_init() in the IBM vTPM driver:
>=20
> [=C2=A0=C2=A0=C2=A0 2.987131] tpm tpm0: tpm2_load_context: failed with a =
TPM error 0x01C4
> [=C2=A0=C2=A0=C2=A0 2.987140] ima: Error Communicating to TPM chip, resul=
t: -14
>=20
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

This is a bug in the hmac encryption. It should be robust enough
to only be enabled if tpm_sessions_init() was called.

It is fine to enable the feature IBM vTPM driver but definitely
not as a bug fix.

Missed this one in the code review.

BR, Jarkko

