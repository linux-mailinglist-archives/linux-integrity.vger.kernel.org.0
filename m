Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22C28E795
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 21:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgJNT7O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 15:59:14 -0400
Received: from services.gouders.net ([141.101.32.176]:33458 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNT7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 15:59:14 -0400
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 09EJskwF025179
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 21:54:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1602705287; bh=jUoYd/A1gcN33exo0qYQZ5igyl8Jm6lM4h2RSJGFf1w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=q90nZmaXhb1ArMz1IRWHC1xrdq9NnF3yNcV1YoxwVEIgux3RQP/FOwaCj49L/kqYm
         v3Rz/vw7XtOlsy3Nyht4JrI6K0WbwHhbBYqljnqYIph3PCl2RVgx8yi+HEce4+eLVB
         ZJHFWNKb+jq0oYwvviyk0aHrIDlPD5JqZLqWx9hs=
From:   Dirk Gouders <dirk@gouders.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: WARN_ONCE triggered: tpm_tis: Add a check for invalid status
In-Reply-To: <7729a41ac22dab84a785bc7a6228af28b814a33a.camel@HansenPartnership.com>
        (James Bottomley's message of "Wed, 14 Oct 2020 11:24:08 -0700")
References: <ghsgagsnag.fsf@gouders.net>
        <7729a41ac22dab84a785bc7a6228af28b814a33a.camel@HansenPartnership.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 14 Oct 2020 21:54:30 +0200
Message-ID: <gho8l4shvt.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Wed, 2020-10-14 at 19:57 +0200, Dirk Gouders wrote:
>> On my laptop the check introduced with 55707d531af62b (tpm_tis: Add a
>> check for invalid status) triggered the warning (output below).
>> 
>> So, my laptop seems to be a candidate for testing.
>
> I'm afraid this is a known problem on a wide range of TIS TPMs ... it's
> fixed by the patch set I'm trying to get upstream:
>
> https://lore.kernel.org/linux-integrity/20201001180925.13808-1-James.Bottomley@HansenPartnership.com/
>
> But in the meantime, it's harmless.  The TIS code at the point in the
> trace is trying to send a TPM2_GetCapability() command which fails
> because the locality isn't listening, but the design of that command is
> only to trigger an interrupt to probe the interrupt handling nothing
> else depends on it succeeding.

Thank you for the explanation and sorry for the noise.  It seems I
misunderstood the commit message.  I will watch the ongoing discussion
you pointed me to.

Dirk
