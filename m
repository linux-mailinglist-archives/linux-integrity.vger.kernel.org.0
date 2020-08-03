Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C375523AA83
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCQcp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 12:32:45 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33316 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQcp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 12:32:45 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7892972CCE9;
        Mon,  3 Aug 2020 19:32:44 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4CBB44A4AE7;
        Mon,  3 Aug 2020 19:32:44 +0300 (MSK)
Date:   Mon, 3 Aug 2020 19:32:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost
 engine
Message-ID: <20200803163244.kcuyvrxxknzcyxhy@altlinux.org>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
 <20200731182408.696931-6-zohar@linux.ibm.com>
 <20200731185633.kqgcz4dwfa4ruyld@altlinux.org>
 <20200731201808.GA27841@dell5510>
 <20200731202638.x5mnkz7hcpgbveu2@altlinux.org>
 <20200731204044.GC27841@dell5510>
 <20200731210653.p5m4efy52melqwgs@altlinux.org>
 <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <8c9e64a3b461fb20cda761ef0fc0728a55448937.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Jul 31, 2020 at 06:32:42PM -0400, Mimi Zohar wrote:
> >   In that case `.travis.yml` should have `dist: bionic`.
> >     https://docs.travis-ci.com/user/reference/bionic/
> 
> Yes, for the internal git repo I made this change.   The internal
> travis support for bionic is different than the external travis.   I'll
> post what I have as an RFC.

Excuse ma, what is internal/external travis? I know only travis from
github.

Thanks,

