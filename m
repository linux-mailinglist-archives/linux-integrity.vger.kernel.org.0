Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE324304
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbhBXRNv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Feb 2021 12:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhBXRNv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Feb 2021 12:13:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C11664F04;
        Wed, 24 Feb 2021 17:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614186789;
        bh=W5K1uBfS6r9MdBgJhTBmMGkO03oGPLrdnMGZiYEBD6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQqe3cOtRClmp8CszgyySqmP6FvI86ERkP3s6zJD5jKnNrNon3Gpt5kSdtMvSpIN1
         gniBJszGL/rBV8SxhaVk6dr2emg19Lggy4/bkp1/hMztJuBDGjkxoser2grySeeWVI
         +xWN4DLrYP3ZKiGYZQ8eGnlY+tOCQZZ2qD8H3MCKOI5sqFdr0B7Rxl+sjkuDMGlQw5
         +bWB8CPQ6A6TEwrDonDbiDV8/xj2OWCaqRz7VWy/k5MpF+el4pP6vo2JGmYoquqt/G
         6hlgfM+gmtqT6pZAFk4Iix9we7YVoJVM2IGK2W34QD9+L8ClRjt+TQvmh5qolAduqu
         91c0GAFnnRIyg==
Date:   Wed, 24 Feb 2021 19:12:52 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 2/9] tpm: Allow PCR 23 to be restricted to kernel-only use
Message-ID: <YDaJFOv6A8i2oU9D@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-3-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-3-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:48AM +0000, Matthew Garrett wrote:
> +#define TPM_RESTRICTED_PCR 23

As stupid it may sound, I'd just change this to:

#define TPM_PCR_23 23

It documents to the code that we are dealing with PCR 23, which just a
plain number doesn't. By naming it as TPM_RESTRICED_TPM you have to
unnecessarily xref to its definition. It obfuscates rather than clarifies
anything important.

/Jarkko
