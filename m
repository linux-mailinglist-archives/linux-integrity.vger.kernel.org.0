Return-Path: <linux-integrity+bounces-6809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE068B23D4E
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 02:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ACC1AA48DA
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Aug 2025 00:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A49273FD;
	Wed, 13 Aug 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN9KOuJA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC49475;
	Wed, 13 Aug 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045627; cv=none; b=m/0NxQyE54WrlA+nruHZw+d9Km4TWuiaxfQkAJOul02Q0OzFrIHBligLQvV+ms1sffIyQTj4IunyiKwMNX7F58RDdvPuxmEGsI+GglydI6w4Mvum9CwZGu1grzsiYRPOtjNTy/ncBVZwe+CNw9v+jNm4EkPLZftGF3Er7ye81PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045627; c=relaxed/simple;
	bh=HHiNHrqHoFp4mXWjjLP4MSJOQcT84nHTXCmLZe8hn5Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mY3hfELDy4zGMHlbirc18P1A6xMA3SZ2CVwIlAqGhOq/IcPleyXYgsWQwNeA+uM/n4rvLCPmgFMIc3xaOhxkGs56TR/SvpHhy9L/Z5EYMnvuTNRfFqGayXHWpAQOFdKHEuxFFSzg/Ix4rUGByoQi+msBdYZDkovGvmzx4xBeLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN9KOuJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE004C4CEF0;
	Wed, 13 Aug 2025 00:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755045627;
	bh=HHiNHrqHoFp4mXWjjLP4MSJOQcT84nHTXCmLZe8hn5Q=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=EN9KOuJAatdaRP2AoNehdooyqe/Ypdg8JFENjdIQCo1cwfP7/UG4qW9sllhsYLvFr
	 eCxHGu9ydF0ilS06Wq8qJW0nQjz8DOWMkfyLm5tsvRvLZ6lAoBh2B+hz6zuWNJDgTl
	 9opdJxRQlbzYuzRcR/ibT2xE3WbG8a/WjIaoPDSw0tyBtEp11+APoU/01oy2uZ+Nc+
	 T9nmt0LcSko8awqNYDrtLSo17/aUdNWY3IWLjCUV8kmaShQlUQ17wm5HOQOSN/L8RJ
	 qbmL2paRXaLUdv6XX9kjuCVSEbccGB64nkvhclQZDSv9ILZWP8duDk46VVVBmMp21N
	 NUFM6mnvwXgQw==
Date: Wed, 13 Aug 2025 03:40:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: tpm2_protocol
Message-ID: <aJve98-cGPKdEOlB@kernel.org>
References: <aJs6rWexGNsH45_Z@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJs6rWexGNsH45_Z@kernel.org>

On Tue, Aug 12, 2025 at 03:59:25PM +0300, Jarkko Sakkinen wrote:
> I came up with this within 1,5 weeks not much sleep, and thought that
> this might be interesting to all of the three lists:

https://github.com/puavo-org/tpm2_library

Known issues; two tests are failing  They work when copy-pasted to cli
without any change, when run in a temporary subcommand, Not sure what 
is going on but looking into over time. And not all subcommands are
yet too well tested or polished ;-)

Features, reference and driver for this work is my earlier trial from
2014: https://github.com/ColinIanKing/tpm2-scripts

And partly this cover letter:
https://lore.kernel.org/linux-integrity/20240528210823.28798-1-jarkko@kernel.org/

[i was planning to update that patch set but was not happy with the
 tools so i decided to make my own.]

With those constraints I learned by trial and error to use macro_rules
and this the outcome. I'm looking forward to narrow the delta between
static estimate and run time 'len()' over time.

This is designed as unipolar TPM protocol stack i.e. it's designed not
only send commands and receive responses, but also send responses and
receive commands.

BR, Jarkko


