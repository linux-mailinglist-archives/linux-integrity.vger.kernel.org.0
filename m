Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574E588491
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 00:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiHBWvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Aug 2022 18:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBWvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Aug 2022 18:51:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E55175A8;
        Tue,  2 Aug 2022 15:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D360B8213D;
        Tue,  2 Aug 2022 22:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4866C433C1;
        Tue,  2 Aug 2022 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659480663;
        bh=EVHKFXDWJx2v89uX2HtMGYWfOO5yohu71hamhjaXdWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDRV1sfNn0/OSf9pd0RZlPlAJjgOj7N7MywwlgUMqTf8eni6vTtrYoqpZrEYfYhBA
         aOtQFFWdGU95r35vAdvxcU5xc0+fa6dTZYpAMBECcGhtQ5t9i9e6sCU3WRJVORb95c
         JVKauXIA0SGkvcnen2WkJk79P5g0U/vtqpfsLWAp4h4zrr/ydUkEi7E61xWPa1fjjG
         bmJqKUpQor5sq5bVdvrdwpg0t16WbAxnD2bMVgCCW8VGubE/++I+uXrtW3pTrB/JU8
         KtW4CEwHKcq8QHVstls+uWAA8TqrLY8RrET/SjAiFJjYE8GYI488m/0tKwQXYzxaDm
         SbolsWHq+t8rQ==
Date:   Tue, 2 Aug 2022 15:51:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 09/10] PM: hibernate: Verify the digest encryption key
Message-ID: <YumqVb5RQQ5knPk7@sol.localdomain>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.9.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504161439.9.I504d456c7a94ef1aaa7a2c63775ce9690c3ad7ab@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 04, 2022 at 04:21:01PM -0700, Evan Green wrote:
> +	/* TPML_PCR_SELECTION.count */
> +	if (be32_to_cpu(*(int *)payload->creation) != 1) {
> +		ret = -EINVAL;
> +		goto out;
> +	}

Make sure to run sparse by passing C=1 to make.  It will find bugs like this
where the wrong type is being used (int instead of __be32 here).

- Eric
