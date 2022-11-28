Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7C639EA6
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK1BMn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiK1BMm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:12:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5D42733;
        Sun, 27 Nov 2022 17:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC87960ED5;
        Mon, 28 Nov 2022 01:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB138C433B5;
        Mon, 28 Nov 2022 01:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669597959;
        bh=zYVNFyzR3ZhxNVgXNk8xgjAdgj0yumLEe+jdBy4bdz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/CsFMpQJjQeXcX42ZV2Fz7ddjDSK8r4kDhNxBohLsMyjt0hIG1Pq1GRuBn7HE/Hq
         CUfJOLDXnGhYCGwHkxEkFr0Uehf6NiqpDacDwrdyYHeVD/TlbxX/S0jvQMfXjAz9iZ
         pPPZXA2+9d/tDP0x8tEr7K8kv4PNHlrJ25tPH+5Ne6ISh5uzc4OBYWc7xOjU5q9D0l
         v/Lx6STlnJ/PQnZayginiqEIEX+TKam9ZjNQoh7zoUi17RsF8/QXY2WJVvaXDoztGn
         7Gs9wCC+7toHvx6IDGeEzpS7YCHlX1cmInuKlWj+mWWq6Jr9pT+tLrIDXy/nc+LEZ/
         GJj8pj0dxAwmA==
Date:   Mon, 28 Nov 2022 03:12:34 +0200
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
Subject: Re: [PATCH v3 2/3] KEYS: Add key_create()
Message-ID: <Y4QLAtL5rbG1rpFr@kernel.org>
References: <20221118040343.2958-1-linux@weissschuh.net>
 <20221118040343.2958-3-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118040343.2958-3-linux@weissschuh.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 18, 2022 at 05:03:42AM +0100, Thomas Weißschuh wrote:
> This function works like key_create_or_update() but does not allow
> updating an existing key, instead returning -EEXIST.

What is "this"??

> This new function will be used by the blacklist keyring to handle EEXIST

Ditto.

BR, Jarkko
