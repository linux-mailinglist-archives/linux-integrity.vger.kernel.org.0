Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9CE735FCD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jun 2023 00:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFSWRY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 19 Jun 2023 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjFSWRX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 19 Jun 2023 18:17:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF18E6;
        Mon, 19 Jun 2023 15:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E7660E9C;
        Mon, 19 Jun 2023 22:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB770C433C8;
        Mon, 19 Jun 2023 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687213042;
        bh=4sh3RxfsfmAtwSyOwC4E6s7/PaOf07c5a/+6EG4z2rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6R1PvpsRinN3FHqqYUoAfTOgBf98rhOYTZcsTiP+jY0hj1oJja8LbOLP6wevAvq3
         awpAwPXDDQM43mkBUOIUSNUWHQyYcGrsDBBgrS2yl3BAr3OVengNUY7OZDe8sIULVa
         +drr+NQ6/ujziowjzhF4EwV8bZyISYDgcQKMT1jTjR9p+DqbP/TlLL70WJ/irCVzwI
         OrKmwkEdsQIr3+v46Qg12v51dL0C6ggsOh97xhgRCf2FSazYKlamj8X71IoHBNH7jP
         20wBfO5C60OdRCbUZ3E5gcDwHGoU8pqnWHbZXJ+9AnID7FhtMKZ67CLjyloHxZOqWc
         XpnsiHdGIdPYg==
Date:   Mon, 19 Jun 2023 15:17:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        Colin Walters <walters@verbum.org>,
        Alexander Larsson <alexl@redhat.com>,
        Luca Boccassi <bluca@debian.org>,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v2] fsverity: improve documentation for builtin signature
 support
Message-ID: <20230619221720.GA2993@sol.localdomain>
References: <20230619221048.10335-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619221048.10335-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 19, 2023 at 03:10:48PM -0700, Eric Biggers wrote:
> +  authenticate applications before loading them.  In these cases, this
> +  trusted userspace code can authenticate a file's contents by
> +  retrieving its fs-verity digest using `FS_IOC_ENABLE_VERITY`_, then

Sorry, the above is supposed to say FS_IOC_MEASURE_VERITY.

- Eric
