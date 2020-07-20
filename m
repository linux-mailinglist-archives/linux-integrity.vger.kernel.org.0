Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D363C2259C7
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 10:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgGTIOC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 04:14:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgGTIOC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:14:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C2E0ADC1;
        Mon, 20 Jul 2020 08:14:06 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:13:58 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 2/3] ima-evm-utils: output specific "unknown keyid" file
 msg based on log level
Message-ID: <20200720081358.GB11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
 <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-2-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> When the IMA measurement list contains file signatures, the file
> signatures are verified either by calculating the local file data hash
> or based on the file hash contained in the measurement list.  In either
> case a list of trusted public keys needs to be provided.

> In addition to the list of known/unknown public keys needed to verify
> the measurement list being output, the specific files signed by an
> unknown public key are output as well.

> Output the individual "unknown keyid" file messages based on log level.

> Example 1: "ima_measurement" list of known/unknown public keys

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
