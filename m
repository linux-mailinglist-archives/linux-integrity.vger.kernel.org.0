Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D11E4A72D5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 15:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242361AbiBBOR6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 09:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiBBOR4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 09:17:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97819C061714;
        Wed,  2 Feb 2022 06:17:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 382E2617E1;
        Wed,  2 Feb 2022 14:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F192CC004E1;
        Wed,  2 Feb 2022 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811475;
        bh=Kk7niat406HYHKy3pgAGX/5iWKJRtBzR6KIcTCFSZPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXynr+OclZsvxHtmkDsgZiCqI5jM8LpZNvIyB4hMzeu1Y1VwK4d6xxdcZA6bTFiSy
         hGMy7KiH9hzKJ7GN77bQx1j8a7XYxjnY9nppjSmLqVoUJR4PpYS0vEJb29BiH70QDr
         KoZLvx/kbcWnUZleG/e93Lj0uZm66G0ONK9X/ku/JxZgY3X6Yzt/VhL7y7MxCuJRgZ
         ZAZO1ghdR4yw/tuoFnGW10ZwjmvTz8IR33XiOFdyv/nNaKXQ0Laf2NbmrKodG0tDRP
         yRK20oi/+z7eTh2KpEn6OZiU3izLjexTo7UpIEDlgK8jKj/gl6upX9vD/6IkUfgMxR
         XsTakfbP6Mzvw==
Date:   Wed, 2 Feb 2022 15:17:43 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: Re: [PATCH v10 02/27] ima: Do not print policy rule with inactive
 LSM labels
Message-ID: <20220202141743.nqs6tprbmmmufbyw@wittgenstein>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201203735.164593-3-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 01, 2022 at 03:37:10PM -0500, Stefan Berger wrote:
> Before printing a policy rule scan for inactive LSM labels in the policy
> rule. Inactive LSM labels are identified by args_p != NULL and
> rule == NULL.
> 
> Fixes: b16942455193 ("ima: use the lsm policy update notifier")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Ok,
Acked-by: Christian Brauner <brauner@kernel.org>
