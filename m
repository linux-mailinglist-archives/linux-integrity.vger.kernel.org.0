Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69852AE77
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiEQXNj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 19:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiEQXNi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 19:13:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4837A1C
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 16:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C961B81C08
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 23:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E07EC385B8;
        Tue, 17 May 2022 23:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652829214;
        bh=/FBQy3S1fLrTPPq3XIMDjqvd1sUq1didVbcLuRGYFMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQrmB4P6Y/ogVdg0zMNhCNgvAZ0/X2v41BvVa35okdCMYNWaLkaC/OPRFFPzqM0vh
         kz1tCOzLNDWdgV6vAv31in6NVs4aC0FaKJ6XnVYZ5XajiV9/HpEDAJ9Imcs42feXnP
         MwsedaB+P8YvUrYAF0t8T18iHLc4T1ACwZJMuDabATRehnBvw6V0T0U1TphZdZIEzY
         4Xwsz/x3BmuDDhaee3yNmfPqt21uHBbh7RmHIxBZH7q9gVQ+58SZUuF+lRVvQIKyUe
         gabkOvzzgwMgdPgejs9HDia0WB3alZbKlICocUXFH8W5tVq1GFlDmpGTBbF4IfN3iq
         GkQUhwZ2HPcFg==
Date:   Tue, 17 May 2022 16:13:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils 2/3] Sign an fs-verity file digest
Message-ID: <YoQsHLCRTzeflUKg@sol.localdomain>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
 <20220512183056.307597-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512183056.307597-2-zohar@linux.ibm.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 12, 2022 at 02:30:55PM -0400, Mimi Zohar wrote:
> Sign fs-verity file digests provided in the format as produced by
> "fsverity measure".

This is correct, but it probably would be more useful to give "fsverity digest"
as the example, since "fsverity digest" doesn't depend on the file already
having verity enabled.

- Eric
