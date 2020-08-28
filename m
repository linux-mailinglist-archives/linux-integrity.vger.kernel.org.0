Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8A255905
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgH1LB2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 07:01:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64908 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729052AbgH1LAz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 07:00:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SAYCHI078784;
        Fri, 28 Aug 2020 07:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GivPtg5Q6jCqSAOm34kakRpPbv2idGi4QFfGncnfcP8=;
 b=O5kCB+pttM3PGBkxNQ2v6Ishss8UkEMvxlzKpIX8/XyZ4zori4Yv4WsmB2O56Gb45CDw
 HEiRPDczPKqvvBt6bGFlLLRsU/U3keyVWlZvOtG3qJs1U+jHI7M8B9QVKDYaJdGvuxqA
 wC0wMvkIoo3tXuoYW41vBG1pbvtmTGtoWT0Q72YZD9Oo4K1sBSkfy/EWmmgixG5fVXyp
 1VVykt+K2peR2Nqkk+brpBPps92hRhX4aDR2s4Zy3xUtPSq58gClUXoo+qIhctBaby3P
 SXMuayW0gm+1y1tSLGiZzLDXNSAeoNGjO8HSMPpmBer6xlt5fUqKTEdz/Lj1b4FdtJSN LA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 337024gx1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 07:00:44 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SAmFf1016033;
        Fri, 28 Aug 2020 11:00:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 335j271j3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:00:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SAx9At66585036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 10:59:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B9AAE063;
        Fri, 28 Aug 2020 11:00:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA905AE053;
        Fri, 28 Aug 2020 11:00:38 +0000 (GMT)
Received: from sig-9-65-214-13.ibm.com (unknown [9.65.214.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Aug 2020 11:00:38 +0000 (GMT)
Message-ID: <009fac799e088345fbddc7ca7456e19a87d893da.camel@linux.ibm.com>
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 28 Aug 2020 07:00:37 -0400
In-Reply-To: <20200828060554.GB15251@dell5510>
References: <20200820090824.3033-1-pvorel@suse.cz>
         <20200820090824.3033-5-pvorel@suse.cz>
         <b58057275ecdc06bb512d39ea46118197f33c33f.camel@linux.ibm.com>
         <20200827132354.GA20439@dell5510> <20200827135503.GA11990@dell5510>
         <b72657042d13f9b8f30d5bdea7e2d06835e4a1d1.camel@linux.ibm.com>
         <20200827225417.GA29921@dell5510>
         <d6087ee43d18605ee6cdc6b80450b0024af14fb6.camel@linux.ibm.com>
         <20200828060554.GB15251@dell5510>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_06:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 suspectscore=4 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280082
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-08-28 at 08:05 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> > Thanks, Petr.  This works properly.  To remove the "hack", would
> > require running the test from "ima", not "ima/tests", but that would
> > require fixing how ima_setup.sh is called.   It also would still
> > require setting TST_DATAROOT to TST_DATAROOT/$TST_ID.
> Let's keep it and suppose people run tests from ima/tests.
> This needs to be fixed on LTP side, I have it on my TODO list.

Sure
> 
> Anything else?
> After that I'll work on ima_tpm.sh and after on policy automatic loading.
> BTW there are also plans for reboot support [1] [2], that could be used as
> workaround for configuration without CONFIG_IMA_READ_POLICY=y and
> CONFIG_IMA_WRITE_POLICY=y.
> 
> [1] http://lists.linux.it/pipermail/ltp/2020-August/018636.html
> [2] http://lists.linux.it/pipermail/ltp/2020-August/018658.html

Sounds good!

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> for the entire patch set.

thanks,

Mimi

