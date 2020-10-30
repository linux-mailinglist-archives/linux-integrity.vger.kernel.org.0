Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182A02A0B83
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 17:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJ3QnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 12:43:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42548 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3QnP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 12:43:15 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6DB2820B4905;
        Fri, 30 Oct 2020 09:43:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DB2820B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604076194;
        bh=IaotcXMpeIJAOCC8PWk+3p2VsFBW9Ups0sK9vDE+00k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hk5vG6G8Al3QxurWYrUGXqSAQ+3w04Az1PgUaOLf8xwTrTMMmR5sjqwK/Pqlnf59j
         SSLvMpp4DjrfNLT6ctT1RSSjzQO3JzBYq/h4tKqo13Y2QyxCqg+Rke8IhEdhylpHV3
         8dzLBo7QaFTurX5PWmqKIvdosJ3SHshWXH3Ecp78=
Subject: Re: [RFC] Finding the right target branch for patches that span IMA
 and SeLinux
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        paul@paul-moore.com
Cc:     SELinux <selinux@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <703ced1a-3a48-f29e-9141-af78415d8402@linux.microsoft.com>
 <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <2ea3d341-6299-ec40-b553-f9f59a36cfb3@linux.microsoft.com>
Date:   Fri, 30 Oct 2020 09:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f99f0f03aecc778826d79eb83d60cfd1a95196c5.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Unless this patch set is specifically dependent on the two patches in
> the SELinux tree beyond v5.10.0-rc1, please base it on v5.10.0-rc1.
> 
Thanks Mimi. We don't have dependencies on those two patches in SELinux 
tree.

We'll base our changes on v5.10.0-rc1 in SELinux tree.

Thanks for the quick response.

~Tushar

> thanks,
> 
> Mimi
> 
