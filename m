Return-Path: <linux-integrity+bounces-2809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E09D8FBD6C
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 22:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED9A1C20C2B
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8881487F6;
	Tue,  4 Jun 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5ctZpFy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629E17C96
	for <linux-integrity@vger.kernel.org>; Tue,  4 Jun 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533395; cv=none; b=Su/tf6NmEIJ9834ryo8r8Pi/iX6r6lwUSPlydQk3a/LBZJlTwZtzu6kL+2KryNtqc5ybs+uIVojkYpL15MlEYAWW9FkKlk95VsP5Pq++Hx6SWADdVVT5Q25W8w25PmQV6xs/X7he6T05uG/mtn/69x3CfiHKChZCDGgpAlVjusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533395; c=relaxed/simple;
	bh=8gsMOncizMAfkLM9jb26TPlPVEdINwCiK02q/p2lKo0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mJGZ4TVPk1ptZoW0qsJUVdN84hhUantB6OMHJmboefJ4PtBFr9ZOLSg3BCQ86zKn4VJHp7PRm4pjq1t8ivyw4SaJ4Lc6TM6e6fboghRPgKfF4Nq1nJE3SoCZuZkAahKpLJkPQopnaRF0RQI6KAQ2JNJFGZPxWs4MxKII0q01MM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5ctZpFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF6AC2BBFC;
	Tue,  4 Jun 2024 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533395;
	bh=8gsMOncizMAfkLM9jb26TPlPVEdINwCiK02q/p2lKo0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=J5ctZpFyCCVrIy84ZAYXtpa9l+Gl6U3dd/3a3FGHT1W2BaoZdOdyyLqKXZ5iiSlPs
	 Pm83EEtqMDWqWBdLJNAyOtHaYKXY4JwRynXfQTmubDK7s4bjZ2a7G+vvPQg0z/nqfW
	 zbRSq2dQ7nQU/CKkmSS4GLSGAZipP4GELAXaV7f+SEqiVCB4nvkzMvfuGoGSVrgSvs
	 tbjimd4NNVeWx9S25KAmgax8ygrid9m1Xsh5/lsOeYC1TK4mVggAogBd5nCPLHPuas
	 xyB1JX0LhxLpNPwLeBgutb0TvkWvLjNSTrqXYtjJxsEF0BqUlwKagi74jpXQHRaXCH
	 kIBUUbR+su0kw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 23:36:32 +0300
Message-Id: <D1RIRVZ2K03E.1JHL5XMMLN9JL@kernel.org>
Cc: <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm_crb: Call acpi_put_table() on firmware bug
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Joe Hattori" <dev@hattorij.com>, <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <20240531021021.2233654-1-dev@hattorij.com>
In-Reply-To: <20240531021021.2233654-1-dev@hattorij.com>

On Fri May 31, 2024 at 5:10 AM EEST, Joe Hattori wrote:
> In `crb_acpi_add()`, we call `acpi_get_table()` to retrieve the ACPI
> table entry. `acpi_put_table()` is called on the error path to avoid a
> memory leak, but the current implementation does not call
> `acpi_put_table()` when the `length` field of `struct acpi_table_header`
> is not valid, which leads to a memory leak. Although this memory leak
> only occurrs when the firmware misconfigured the ACPI table, it would
> still be nice to have this fix.

1. Drop the hyphens.
2. Wouldn't it be memory corruption, and not a leak?
3. Why would ACPICA return corrupted data in this case?

BR, Jarkko

