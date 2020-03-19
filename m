Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D9B18BCAF
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Mar 2020 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCSQgs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Mar 2020 12:36:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgCSQgs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Mar 2020 12:36:48 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 77B1420110DE;
        Thu, 19 Mar 2020 09:36:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 77B1420110DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584635807;
        bh=yd9d5arS28Y0MpXzfyytl10uscUOaQkwlZq8s74jEA4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=NzrR39pWMRN/5Rrt7s+my6cdXvTRSQNOxDrucJFta8Lj0EAJyxJV53rjJJIeSlkMR
         5v8Po3qQ0VzZrDtkeJrL78rEfeoXFv6VG+bltZycoY6bSpfUc49Ixa2PiNOklPXXSJ
         qjsAE4U+TnpKCMqMXTQvACWSPYMwoSCORCBuiOWY=
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
 <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
 <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <a8b77ade-58bf-88ac-542b-b8fbdd651db4@linux.microsoft.com>
Date:   Thu, 19 Mar 2020 09:36:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/19/20 8:49 AM, Vitaly Chikunov wrote:

> 
> Please run autogen.sh twice before running configure.
> 

That fixed the problem. Thanks Vitaly.

  -lakshmi
