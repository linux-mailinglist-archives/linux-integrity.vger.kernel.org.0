Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113813D2460
	for <lists+linux-integrity@lfdr.de>; Thu, 22 Jul 2021 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGVM3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 22 Jul 2021 08:29:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42616 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhGVM3h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Jul 2021 08:29:37 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A6B402261C;
        Thu, 22 Jul 2021 13:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626959411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RLZBDzrlhwClLH14d41Og+ohd8t/ev9k3JcougZeZA=;
        b=pU5mNF5NlrxxyFxYK3pX3LJgLmkKaCEj8++Ryqw7rs6hoU34PMPeEMIum02AQyM6I2Fl/j
        udUnIU9/Vx+yaOaYYsBpwiHYfQPLooqi8xlEdF9IGItseQ3sI9Yxcese3jlt+UYYq1Geei
        iOF6m1PB8VWa7SGaCfX/I1BdTDiSPGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626959411;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RLZBDzrlhwClLH14d41Og+ohd8t/ev9k3JcougZeZA=;
        b=abYG99bC9EmrvGMRgM1i0mYaR+rhYy8M3fEGT30/K2jC+3mTB+bXH4kqpXuHhuISlg1T/e
        zXzipErUfx8EUBCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 63475139A1;
        Thu, 22 Jul 2021 13:10:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id NTCCFjNu+WDTcwAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Thu, 22 Jul 2021 13:10:11 +0000
Date:   Thu, 22 Jul 2021 15:10:09 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: Fix incorrect algorithm
 name in hash_info.gen
Message-ID: <YPluMV2uUhela5hN@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Agree with Mimi to update the comment associated with this change.

Kind regards,
Petr
