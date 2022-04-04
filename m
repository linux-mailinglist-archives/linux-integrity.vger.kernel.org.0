Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0394F2037
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 01:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbiDDXXo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 19:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiDDXXn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 19:23:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CBE11A1B
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 16:21:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BF76B81AB7
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 23:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89A7C2BBE4;
        Mon,  4 Apr 2022 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649114504;
        bh=WPkLYEqwwbDwvSbNDzcqSOjHxlSwfNbwpyAQBHInM7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sQYY59ZAgsspIOiasMZEE2oF9HkEQRaMMkGhGzbhAgDh4BpxiEwgdlESos/j78toX
         7xf9vlYwdlQuPNIPQ5YhJ8z086MB7PCOVLamB8ZUEaUPn/IpTJHJ4ZbWbcuGZM3Zqo
         5cU1gJfL4ywIQW7e4FbyQdSCKTz/PT/LcDVfv3QF27S9BpcaIGk3Fnp2x46PFKVfES
         dsceyaZfZsk4HorXT1OVQUUiB6iDkPO4OOKJCZaR2TSHaL7FOJQjr/aCl9o32ye9hl
         UPnK12pXfDSatgotOe+U48ihGPQgZZzqaOtP/WeXCS2THtkgoQ4ygcrQyfnU31yiNO
         tmop+DqC5dLMQ==
Date:   Mon, 4 Apr 2022 16:21:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jes Klinke <jbk@google.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: PATCH: Google security chip, additional DID:VID
Message-ID: <Ykt9hoX+mPG1oirv@sol.localdomain>
References: <CANMTAZSQgokaG7ZaqipcR56yzOK7iDq50P0_GKd-H7nxUX3TzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMTAZSQgokaG7ZaqipcR56yzOK7iDq50P0_GKd-H7nxUX3TzQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 04, 2022 at 04:00:31PM -0700, Jes Klinke wrote:
> Hello Peter,
> 
> I am a firmware engineer working on the TPM chip in Chromebooks (known
> as cr50).  As we plan to deploy a new codebase on our TPM chips, we
> will have them present a new DID:VID value, but otherwise follow the
> same protocol as the existing implementations.
> 
> The below patch has the effect of accepting one additional numerical
> value, and logging one of two messages, depending on the value.
> Unfortunately, I had to reverse the indentation, so the diff appears
> to touch more lines than it needed to do.
> 
> I am unsure which procedure to follow, as this is my first kernel
> patch.  Let me know if posting the patch inline like this is not the
> way to go.

Can you take a look at Documentation/process/submitting-patches.rst?

- Eric
