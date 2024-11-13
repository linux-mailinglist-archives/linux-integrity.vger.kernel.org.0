Return-Path: <linux-integrity+bounces-4115-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD329C7E5C
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 23:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C99286DF2
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 22:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4D18BBAB;
	Wed, 13 Nov 2024 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezp+muaT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D161442F6
	for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2024 22:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537808; cv=none; b=Jo7P3C/Mzy17mbu0lDKyq5m3+Ccb/PJJYoKyazxrIL3dS+0TQb6DkGrWjpCWVfGK7/VHWwlJX6dYyYk7eIaW1+cudJO9ZNVQoCRqWbFXiznOZVTJ8+AlAtpoAamjEV5PoBAVE7lwqa6iPN3VGuk5RVMY/TEv093dzUM9C5Z2ukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537808; c=relaxed/simple;
	bh=QrqPMLzt7zaycX2mZEBKfB2uHCdj+QwW4y1ZaTMY/XU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=aOVj9qHnPLAdpMVPjgEdv4OQ2rRiAPh55YheAoA85FXy7EuQLiKqXHZZasp0RirxTB8nod6qh3YT0eQKo3myNRcd3JUgvaSKKuh6jJ3i5svg/eQ3/RSlj19OX6b8VbFdi+B8IbL6UaOODZmMFFcLFILFe6mSfg/jKBPvwFAEtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezp+muaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3DDC4CEC3;
	Wed, 13 Nov 2024 22:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731537807;
	bh=QrqPMLzt7zaycX2mZEBKfB2uHCdj+QwW4y1ZaTMY/XU=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Ezp+muaTEmaU6uGbpmFTbYdHlwHqjmdZlK7H3yIbgbCPzY02B3hpcmAP5X1POsuyv
	 VPGkXXspTSihZ6CCx7RKOKdljIn3g+IQe77Obe1/sE3xrG+C59baJUzAQ9ct3q2Glm
	 kLXEfooc2K2erC2jVY4dmlTJZa/LprErq3uVbpWt36m1fIGglSi7zkLTu9yiTkaWO2
	 zCPbkcOSQstU0yj8q+0QIoyskNoWysRW93ojhiCb6L9gZeeEBIfCFGKgeBID9iMobo
	 FyLbqdeY3JIaStF+WoS0Ii9Elu2VwfVoNjrg5IqR87SXcKREz7AdWnpTrl4GE8VBp7
	 q9NpFeVilg/PA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Nov 2024 00:43:23 +0200
Message-Id: <D5LEX9EGE4GB.1XQ5BNQ0GW24S@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Christoph Anton Mitterer"
 <calestyo@scientia.org>, <linux-integrity@vger.kernel.org>
Subject: Re: regression: kernel log "flooded" with tpm tpm0: A TPM error
 (2306) occurred attempting to create NULL primary
X-Mailer: aerc 0.18.2
References: <693caa85c3ee1b3117a562894971de60b6842d00.camel@scientia.org>
 <8fe12e2eb9beb159d2af8462fa0b9b1f946deacb.camel@HansenPartnership.com>
 <89542959611252d64572ffad438f48b4f54131f0.camel@HansenPartnership.com>
 <D5LEQGJ9X3NF.3K3YVPNE6KQJK@kernel.org>
In-Reply-To: <D5LEQGJ9X3NF.3K3YVPNE6KQJK@kernel.org>

On Thu Nov 14, 2024 at 12:34 AM EET, Jarkko Sakkinen wrote:
> I've never got hibernate working even after trying and without even=20
> having TPM in the configuration so pretty hard to test it beforehand...

Hibernate really would need CI if there is even an aim to keep it
unbroken because I've actually never even met a first who has it
working, and neither any CI bot has complained me of hibernate not being
woring :-)

So I neither could give a promise that "this won't happen in future"
becaus there's no means/tools to guarantee that.

BR, Jarkko

