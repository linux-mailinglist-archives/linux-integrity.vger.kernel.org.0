Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958E028E8BB
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Oct 2020 00:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgJNW2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 18:28:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbgJNW2T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 18:28:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09EME5Go042515;
        Wed, 14 Oct 2020 18:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=maDsznPc30xxzlFJkXf1VRSMUiRwkdduwJm1xlNv+dI=;
 b=Q4GUro/6Tg+ASJVIA7RDGJhJVx/OutsU2USLKaycbbNVI1K01SoeHWVUb6P82z7AxTde
 R4jgOUj3Tw4Ihu9x+K0vY/Z1ZxhwJiIgYOeQqLRwrRVyfTOfy1PwyydPx+aHEjtdmJfl
 jNHzPV+vwibZUeR8+u+5si1e1BvTaTLz55E+fDmoGfyFgZCMJh8+ZCB4ewlp47o9L3Fm
 SnrvTKH0yO7fQNsc09Zb5q6SW8GAFWurupkAP6NNgs+Ed4cZYCkF31V/5pk8UhU9B5Uv
 IoHSBqDDykczmCjcoHQgZP1OgIh8xd8DzVoNMxsrarZ4uyQ8i7BPbvGiDttLuaPoWDsm 7A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3469xg89t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 18:28:15 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09EMIOBx009038;
        Wed, 14 Oct 2020 22:28:13 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3434k84kjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 22:28:13 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09EMSBsj30015992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 22:28:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0027F4C046;
        Wed, 14 Oct 2020 22:28:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D52BE4C040;
        Wed, 14 Oct 2020 22:28:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.12.97])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Oct 2020 22:28:09 +0000 (GMT)
Message-ID: <a0060e2dd23281b1dbcc0d71f7615d46dd6f5aa7.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Change env variable
 TPM_SERVER_TYPE for tpm_server
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        Ken Goldman <kgoldman@us.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>
Date:   Wed, 14 Oct 2020 18:28:09 -0400
In-Reply-To: <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
References: <20201012234416.20995-1-kgoldman@us.ibm.com>
         <20201012234416.20995-2-kgoldman@us.ibm.com>
         <ac8d885af1f79a8d1e2c137654b9924693b328b1.camel@linux.ibm.com>
         <fc912ea2-ef89-7fc4-8bf2-5f107b8cfc7e@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-14_12:2020-10-14,2020-10-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140150
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-10-14 at 18:17 -0400, Ken Goldman wrote:
> On 10/14/2020 6:04 PM, Mimi Zohar wrote:
> > Hi Ken,
> > 
> > On Mon, 2020-10-12 at 19:44 -0400, Ken Goldman wrote:
> >> The default value raw is appropriate for 'swtpm'.  tpm_server
> >> uses the Microsoft packet encapsulation, so the env variable
> >> must have the value mssim.
> >>
> >> Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
> > 
> > Thank you for noticing this regression.
> > 
> >> ---
> >>   tests/boot_aggregate.test | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> >> index 1c7b1f2..b109a32 100755
> >> --- a/tests/boot_aggregate.test
> >> +++ b/tests/boot_aggregate.test
> >> @@ -35,6 +35,7 @@ else
> >>   	export TPM_COMMAND_PORT=2321
> >>   	export TPM_PLATFORM_PORT=2322
> >>   	export TPM_SERVER_NAME="localhost"
> >> +	# swtpm uses the raw, unencapsulated packet format
> >>   	export TPM_SERVER_TYPE="raw"
> > 
> > Instead of adding a comment here, how about only exporting
> > TPM_SERVER_TYPE for "swtpm".
> 
> That certainly works.  I thought the idea was, "Make the
> smallest change that fixes the problem."   Moving that
> line under swtpm is a reasonable alternative.

In this case, moving the line and adding the comment is the smallest
change.  To indicate this is a bug fix, you would add "Fixes:
f831508297cd ("Install the swtpm package, if available") in addition to
your Signed-off-by tag.

> 
> I'd leave the comment.  I suspect many people
> don't know about the Microsoft TPM packet format,
> so the line would otherwise be confusing.
> 
> > 
> >>   
> >>   fi
> >> @@ -73,6 +74,8 @@ swtpm_start() {
> >>   			SWTPM_PPID=$!
> >>   		fi
> >>   	elif [ -n "${swtpm}" ]; then
> >> +	        # tpm_server uses the Microsoft simulator encapsulated packet format
> >> +                export TPM_SERVER_TYPE="mssim"
> > 
> > Exporting TPM_SERVER_TYPE like this is causing openssl/tumbleweed to
> > fail.
> > 
> 
> That's odd.  Are you saying that openssl uses the env variable
> TPM_SERVER_TYPE?  What in openssl fails?  What's the error
> message.

"make check" is showing:


TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
3: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
4: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
5: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
6: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
7: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
8: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
9: pcrread: failed, rc 00000100
TPM_RC_INITIALIZE - TPM not initialized by TPM2_Startup or already
initialized
INFO: Calculating the boot_aggregate (PCRs 0 - 9) for multiple banks
Failed to read any TPM PCRs
errno: No such file or directory (2)
SKIP: evmctl ima_boot_aggregate: 

thanks,

Mimi

