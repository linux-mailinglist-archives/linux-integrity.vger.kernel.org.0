Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DCC300BA0
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jan 2021 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbhAVSmp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jan 2021 13:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728630AbhAVSTH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jan 2021 13:19:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D1C23A6A;
        Fri, 22 Jan 2021 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611339507;
        bh=KNhTFj4b/WjHeWypkT82xEpFT9PVrz9GAch5QmpPHO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhAgBJQXrcMcoqHefvG5loiFOINdoHPtPPQp73Ukao4L9S/90LjNnNVFp/EgeRnxx
         jtc5UPB1ClAdSjAev2DKAz6MLfD29rmtFClcNRg4lNXwcVsuNEL24pQ9Jrpjpsze9/
         rABszlpk2JSQhCJXyjU+TwWsDo5r9dRTi7SEb7+/tIKu1jXn0kt9/Eco17fHrH9b8P
         Z1wu3z0LWuWTRlJjKedYcvmQffmb4TzHvgVokt1ZYtu4P6Bm9R8NoAqqMVduUgQxUP
         Npsr5+jOKBmV+yBuKW6NQwNKLI8YZWgaCPZd9RDZ56EXPp/dsrj8l7Qv/qTO4VTsn0
         ldxvffAhVIprg==
Date:   Fri, 22 Jan 2021 20:18:24 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, kernel@pengutronix.de,
        Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Dmitry Baryshkov <dbaryshkov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 2/2] dm crypt: support using trusted keys
Message-ID: <YAsW8DAt3vc68rLA@kernel.org>
References: <20210122084321.24012-1-a.fatoum@pengutronix.de>
 <20210122084321.24012-2-a.fatoum@pengutronix.de>
 <YAsT/N8CHHNTZcj3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAsT/N8CHHNTZcj3@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 22, 2021 at 08:05:51PM +0200, Jarkko Sakkinen wrote:
> On Fri, Jan 22, 2021 at 09:43:21AM +0100, Ahmad Fatoum wrote:
> > Commit 27f5411a718c ("dm crypt: support using encrypted keys") extended
> > dm-crypt to allow use of "encrypted" keys along with "user" and "logon".
> > 
> > Along the same lines, teach dm-crypt to support "trusted" keys as well.
> > 
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
> 
> Is it possible to test run this with tmpfs? Would be a good test
> target for Sumit's ARM-TEE trusted keys patches.
> 
> https://lore.kernel.org/linux-integrity/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/

Also, I would hold merging *this* patch up until we are able to
test TEE trusted keys with TEE trusted keys.

/Jarkko
