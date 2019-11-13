Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75778FBB40
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 23:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMWBM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 17:01:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54096 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMWBM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 17:01:12 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6480A2010694;
        Wed, 13 Nov 2019 14:01:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6480A2010694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573682471;
        bh=H8ROOotMErGhsPgzlUTA9g9jyYKPNLfKgVeFGoDXO0w=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Hh26EjS9HP2CioZrflBry5M8GXQKEbVV5r1QEWkj1Sjq+abK+mUXtpy5yeSwsZIO6
         ZOSrdBUVcDmKoIqg4AdE3kySHaKMi9vU0xgFXnbZkQSqx+IDIb+I/Spn4Aho1dRKgw
         pgDWQ1V388bL7jwRdP8Q/HfGfeHXuJjMsXkbQRd4=
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
To:     Mimi Zohar <zohar@linux.ibm.com>, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
 <20191113184658.2862-3-nramas@linux.microsoft.com>
 <1573675761.4843.13.camel@linux.ibm.com>
 <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
 <1573679903.4517.5.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1e40a6c5-13b9-38e2-d855-7c5334922dec@linux.microsoft.com>
Date:   Wed, 13 Nov 2019 14:01:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573679903.4517.5.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/13/19 1:18 PM, Mimi Zohar wrote:

> Yes, thanks for pointing out the "#ifdef CONFIG_KEYS" in keys.h.  A
> separate file is needed, as you pointed out, but still no need for a
> new Kconfig.  The ima/Makefile can be based on CONFIG_KEYS.
> 
> Mimi

Sure - i'll try it now and send an updated patch set.

thanks,
  -lakshmi

