Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC178389B
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Aug 2023 05:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjHVDle (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Aug 2023 23:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjHVDld (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Aug 2023 23:41:33 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 20:41:32 PDT
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F946186
        for <linux-integrity@vger.kernel.org>; Mon, 21 Aug 2023 20:41:32 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1692675197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTs14t3rJwjJ8nQIqP8mM2RUjVXGIHh5DU3GMM4wEaM=;
        b=m8iZiLA5iTjxOVO6RAvgVGnFLhqNo4J7Kd+gqBuuDLHBH/K+T6EukywHTGnK+98TFwUIbL
        OWXj3gSGR+IlKlUKPydmO9miicRfd0NGDuB9Q5TrkJzisacFjXoS2Q/KIEoXse66lX2f8x
        dyCh+y0OTbVKkm9Ms/jPERaYR5AKz2k=
Date:   Tue, 22 Aug 2023 03:33:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <5c5de3dee5e5fcc4fbdf80226f0697f6269c585f@rjp.ie>
TLS-Required: No
Subject: Re: [PATCH v2] tpm: Don't make vendor check required for probe
To:     "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ps@pks.im, rjgolo@gmail.com, todd.e.brandt@intel.com
In-Reply-To: <20230821140230.1168-1-mario.limonciello@amd.com>
References: <20230821140230.1168-1-mario.limonciello@amd.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mario,

Thanks for the patch. I applied v2 to linux v6.4.11 and it resolves the
issue on my workstation with the intel ADL fTPM.

Tested-By: Ronan Pigott <ronan@rjp.ie>

Cheers,
Ronan
