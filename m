Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925C64F2127
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Apr 2022 06:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiDECkM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 22:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiDECkA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 22:40:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FD2921E1
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 18:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BA4C60DDD
        for <linux-integrity@vger.kernel.org>; Mon,  4 Apr 2022 23:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E33C2BBE4;
        Mon,  4 Apr 2022 23:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649116724;
        bh=wL0AvquUaltiJYos7r/r/kHsQFf77whBwQb4Z/k9moc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZeXPyRd9IKFvGmmkuiR2PKFb9V+dDxjvV+cnpm8suKkjNSuxsZ9kbOlpWYtNSHqz
         614cUg4CkrMI+GP/Vd9dnAhH+GmTBRMbHr1n82wbY6QAUOZUVI9OCXiu7n0/fK6CDt
         tLjz7wTVlu+Lc/gM0lDP4fpKJIEYXUCkfMgTjAsSzC3VIX+jf405dOF4asSoK6Aok0
         EWOVypN2A6FfwrU+se4IYwID5poRHhDy5r0AuG3wZa4W5vLUaaKqOPWFqGpwkYD34P
         4v99tHy7x/cJMy4I8WyOFAf8OL6vN1upp9oNzlE0PNbxg9yaxcqK5wRYGyXIt1rsMg
         yFysji5OMPrXA==
Date:   Mon, 4 Apr 2022 16:58:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jes Klinke <jbk@google.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Subject: Re: PATCH: Google security chip, additional DID:VID
Message-ID: <YkuGMzkivenBgSmO@sol.localdomain>
References: <CANMTAZSQgokaG7ZaqipcR56yzOK7iDq50P0_GKd-H7nxUX3TzQ@mail.gmail.com>
 <Ykt9hoX+mPG1oirv@sol.localdomain>
 <CANMTAZR-7UEeNXx0Syd+eS7L1K9xc6X9L01UoT50xpDPu4+xVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANMTAZR-7UEeNXx0Syd+eS7L1K9xc6X9L01UoT50xpDPu4+xVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 04, 2022 at 04:44:57PM -0700, Jes Klinke wrote:
> I have sent a separate email to the list with the patch, in which I
> have cut out the long explanation, added Signed-off-by, and added the
> delimiter for the diff.  Let me know if there are anything else I have
> overlooked.
> 
> Regards
> Jes

Please use 'git format-patch', as submitting-patches.rst recommends.  Also run
scripts/checkpatch.pl on your patch.  That will ensure that your patch is in the
correct format.  As-is, your patch doesn't apply.

- Eric
