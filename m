Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DBF232344
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jul 2020 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG2RRH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 13:17:07 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56742 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2RRG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 13:17:06 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7E58720B4908;
        Wed, 29 Jul 2020 10:17:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7E58720B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596043026;
        bh=a5ZO3XwImsJ6xmCVERPzkS/M6810S100UZ5+ojy648c=;
        h=From:To:Cc:Subject:Date:From;
        b=bIlBQZvbRZzqyom4oIbGYsWUJo+yh2NSz5EFuTksM7k92nI4+pHX7biYTtMUsU/TZ
         K5NKZm+DPkuQPj5l5XYsAq9Mh//5zbqfy++gh77u1ZfXBDM7iOmZpnswZSb68c4MCO
         fUKCitoSuYa8cdsDVY6ZYAgt7n/y9fKesrYVwvBY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Measure data again even when it has not changed
Message-ID: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
Date:   Wed, 29 Jul 2020 10:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

I have a query related to measuring data (by IMA subsystem) when that 
data has been already been measured.

Consider the following sequence of events:

=> At time T0 IMA hook is called by another subsystem to measure data 
"foo". IMA measures it.

=> At time T1 data is "bar". IMA measures it.

=> At time T2 data is "foo" again. But IMA doesn't measure it since it 
is already in the measured list.

But for the subsystem making the call to IMA, the state has changed and 
"foo" has to be measured again.

One way to address the above is to use unique "event name" in each call 
so that IMA measures the given data every time.

Is there a better way to address the above?

thanks,
  -lakshmi

