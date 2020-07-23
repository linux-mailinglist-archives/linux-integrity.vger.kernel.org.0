Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5868B22A4F7
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jul 2020 04:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbgGWCB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 22:01:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:54427 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731394AbgGWCB3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 22:01:29 -0400
IronPort-SDR: LYcSWz3SZYTsF4Sr4G/3h0ZWIKFGpanO4CHUwymgoqbFFTGBZ7F9baRliJYkM/VHlQ+wQg0hAC
 CEsVD4EvSDNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="147945576"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="147945576"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2020 19:01:20 -0700
IronPort-SDR: AfB3QoR8dOeXKSTFIzakQUxAEHUMujQi3jKGF0iQjYTddGezShJDyqb54qhIKW8Cu1dgipZN71
 HnoUpqS2iNjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="302149612"
Received: from schwings-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.132])
  by orsmga002.jf.intel.com with ESMTP; 22 Jul 2020 19:01:16 -0700
Date:   Thu, 23 Jul 2020 05:01:14 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     zohar@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] encrypted-keys: Replace HTTP links with HTTPS ones
Message-ID: <20200723020114.GG45081@linux.intel.com>
References: <20200716195227.65839-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716195227.65839-1-grandmaster@al2klimov.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jul 16, 2020 at 09:52:27PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

A commit message should describe action e.g. "Replace HTTP URL with
HTTPS URL given the security concerns and the slow deprecation of HTTP."

> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Please remove this. We don't care about it. Git log should only contain
information either for studying or maintaining the kernel source code.

> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

/Jarkko
