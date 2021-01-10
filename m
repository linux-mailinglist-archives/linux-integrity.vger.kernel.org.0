Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A32F04D8
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 04:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbhAJDPH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Jan 2021 22:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbhAJDPH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Jan 2021 22:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF80122507;
        Sun, 10 Jan 2021 03:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610248467;
        bh=ox1ut7hVVYrKa5F+DtrMnt1bKVMe1dBRNN/sU51U5Tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ar8UbxQNNajdzNw0NSJ0f1hQqJbi2x84v1BK60fO4KV8uXzsThdO446awc/F2Tc6Z
         tLAKXQK+wTZmddzSix6AKVPq9dnria1pAaAlp63DH18hosJFexJvlF/HYWre77u13G
         AUtZcqjnplBnHpNuPmQ0hJmbp4J8ayNxkHD3N4K5pmE8fzMT6OBvt9WIWSYWUqW7pq
         4YRYgY9FYz1MQIU+kuDR+XRoqq8An9A8CjmY0JWAM6SJzVhrIpJTKRG+UnZdYn572O
         MGw9K5LMjDfcBMsBrcUQIM7Txhb67qwJAq4fB7xi88GB5U37k4nAsx7Ia+mEJLvN12
         opzdzFxkndb8Q==
Date:   Sun, 10 Jan 2021 05:14:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        linux-integrity@vger.kernel.org,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
Message-ID: <X/pxC3vvGBsn1T09@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
 <CAFA6WYPEGGDGqryu1UXNeBsN9NxShEbv8CVxOp=Pt9Vc1LXB4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPEGGDGqryu1UXNeBsN9NxShEbv8CVxOp=Pt9Vc1LXB4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 04, 2021 at 05:45:55PM +0530, Sumit Garg wrote:
> Hi Mimi and Elaine,
> 
> Apologies for my delayed reply as I was busy with other high priority work.
> 
> On Wed, 9 Dec 2020 at 22:14, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > From: Elaine Palmer <erpalmer@us.ibm.com>
> >
> > Update trusted key documentation with additional comparisons between
> > discrete TPMs and TEE.
> 
> Isn't this additional comparison limited to a particular type of TPM
> (discrete TPMs) and ignored other TPM implementations (virtual TPM,
> firmware TPM etc.)? I think your later comment about on-chip versus
> off-chip points at these missing pieces as well.
> 
> I would rather suggest comparing TPM and TEE on the basis of
> interfaces and implementation guidelines provided by corresponding
> standards as I think this is the most relevant part to the kernel.

I agree with this point of view.

I'm also finding hard to understand the reason for the thread model
documentation, i.e. how it connects to the implementation.

/Jarkko
