Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369057E24F2
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Nov 2023 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjKFN0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Nov 2023 08:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjKFN0q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Nov 2023 08:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549CA191
        for <linux-integrity@vger.kernel.org>; Mon,  6 Nov 2023 05:26:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF33C433C9;
        Mon,  6 Nov 2023 13:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277202;
        bh=2cvvIHYxXpQRgAXwZcOS2p//leG9T/pxB0OwqoHdu8g=;
        h=Date:From:To:Subject:From;
        b=kejhtZpDiSpmqJddxwvms9PLolzzcArXnMi8sUJ1x4FXsk2/jiSLwq8Vs8Ppe5UzH
         XM9xCZoHvBb/2e5Ic92yeCOYDYi3JTRdvB5nNLrapZgXsDg7/EkrMkna6IY+8n+3he
         501G4AybGVkCGUPOO6lGbuZFX8nt4jYSjoT1Ftys=
Date:   Mon, 6 Nov 2023 08:26:40 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-integrity@vger.kernel.org
Subject: PSA: migrating linux-integrity to new vger infrastructure
Message-ID: <20231106-dashing-caracara-of-serendipity-583ec5@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Good day!

I plan to migrate the linux-integrity@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
