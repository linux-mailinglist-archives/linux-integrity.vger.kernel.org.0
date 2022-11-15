Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8C062AFBD
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiKOXyy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 18:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiKOXyv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 18:54:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2A21B9F5;
        Tue, 15 Nov 2022 15:54:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DF1FB81B7B;
        Tue, 15 Nov 2022 23:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A17C433C1;
        Tue, 15 Nov 2022 23:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668556485;
        bh=mZzH0uh0acP4b2+hbljQK6iWDtVLN6kiCb6ZQr1iESo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/n7Yl0RuP4kgp6O9qWGJbXqV4EZlzrwcHYvNvs1WNlB6GXen7lUDCSS45K2RJcCt
         6DwFc5zZ4ghxIK5QBezw2ErAj1C3EtNI/EaJdRJ0qMokBO3p5ICf8ReSe2pfxBRSWh
         sGHh38CXwkDjP1KyUS+Y7pcLFJ6s9ja+JbpW+687uv7fzd8VhkUrv6Po1PAFF5KE+d
         rOgU6AZlz5pmhxAGwwfpiHrBdqESRLSeb1wh8t5CzYQlSaIEuP1FQem5AS/qkHbF+t
         AV0ChuM5CkUz2PgfeMT1BGBCXCC+SzbcPLIxg4a4nwopJMmFDxzH+Kl6Jo4yqAdq11
         Y4tZITIki6E7g==
Date:   Wed, 16 Nov 2022 01:54:41 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/3] certs: log more information on blacklist error
Message-ID: <Y3QmwVIvwPoeVxVK@kernel.org>
References: <20221109025019.1855-1-linux@weissschuh.net>
 <20221109025019.1855-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221109025019.1855-2-linux@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 09, 2022 at 03:50:17AM +0100, Thomas Weißschuh wrote:
> Without this information these logs are not actionable.

Neither "more information" nor "this information" describe
"what information", right? :-)

BR, Jarkko
