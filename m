Return-Path: <linux-integrity+bounces-6881-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20039B2D0AE
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C459318959CE
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DA14884C;
	Wed, 20 Aug 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE2NF5ae"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C1C142E83;
	Wed, 20 Aug 2025 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649683; cv=none; b=FDuXu4lrrAfiqo+bAEtXJc3RsAu354vG8bwG/8uLXEkqIoEdbebwq5cDzcoUVoDRRINa2ipONQzJuEiKdMCFVEcDmD7utItnqBcvDIFwfNe41G+8WkLijUdecXL2V4qYkaeS9vxdhSP97htGFYjYl88gpfmkw0hXMqaKyhLGF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649683; c=relaxed/simple;
	bh=XeskXZIky+PEIWlOP96HY9yCogbLgJ4FHj85WL9QYx0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKGMy4JT+TdhuDhEv3Cc8sMzWsgpYBD7ozlxp2udGcD7oTa+leqRjNtuAAgU8L1AJdW0a+NBLsKkop9xrymkZgeMZTNEKEfjkbwzQFOBehJOB2nXJROX3KAlxe/KW3Z1OqSJluC1vmpMTeqeUUHeL4OQwptQL/32/YXZqkKFomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE2NF5ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B244DC4CEF1;
	Wed, 20 Aug 2025 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755649683;
	bh=XeskXZIky+PEIWlOP96HY9yCogbLgJ4FHj85WL9QYx0=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=UE2NF5aevfeuz7ZZAxgLfrI0fIYfSacTIW0+LHXfuH1xVyqjcteo643jzIldn2Z1K
	 qAVXmQ4H+Xfjk+u60XCFJI2lG/O+afXd7+DMuT3+I6uwEbrUwOHmg7miRuWVtTnCmU
	 aHVjdlRteuPPLdB3UCkCWlWMmdUM5KowDbmYpu1x/L3WM0vtWk+aK+xWUvXVp73gnk
	 YqiVhRvsF2NMu/UPoBevaOKOg6BdEA/WivVlpB263xcdrkLVYkxYeorMNZ8RVJwENk
	 CmXzqAYwFysj61JUOtSfzkZe23lB2dMdZkSkL5Roci0MBfkWwJfelO3Hjvi615qXrp
	 ULbfWxmr13Ozg==
Date: Wed, 20 Aug 2025 03:27:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: tpm2_protocol / tpm2sh 0.9.0
Message-ID: <aKUWj-QCsMUnysme@kernel.org>
References: <aKUTF6lu5JetDJxX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKUTF6lu5JetDJxX@kernel.org>

On Wed, Aug 20, 2025 at 03:13:11AM +0300, Jarkko Sakkinen wrote:
> I started this project originally in 2024 then I got quickly stuck.
> After one year of processing how to do it the result is no_std, zero
> dependency crate, which does not require memory allocator. It can
> empower both chips, clients, emulators and operating systems. Even tho
> most of the code was written in three weeks (11K of 12K for both
> protocol and client) the ideas have been developing for a long time.

Also tpm2_protocol byte granular precision in its understanding of the
protocol.

We don't need to validate anymore just length or trivial metrics like
that. The power of Rust here is really that we can structurally say
what "is" and what "is not".

It's not just a security property. It increases the overall stability
of the system. One particular benefit that it gives for kernel hacking
is the ability in some cases to differentiate the stimulus of a bug
between kernel, hardware and firmware.

My crate takes byte granularity seriously. E.g. day ago I noticed
that spec had enums with signed discriminants, which I hadn't paid
attention but compiler reminded  me of that by complaining that
building and parsing traits were not available for 'i8' :-) (it
event has separate building and parsing traits for u8).

BR, Jarkko


