Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855D71C90B6
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2020 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgEGOvD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 May 2020 10:51:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19290 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgEGOvC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 May 2020 10:51:02 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EVZiw099365;
        Thu, 7 May 2020 10:51:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gx66p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 10:51:00 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 047EVaKa099414;
        Thu, 7 May 2020 10:50:59 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4gx66nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 10:50:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 047EoVk2001696;
        Thu, 7 May 2020 14:50:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5uhsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 14:50:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 047Eotsi66322592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 May 2020 14:50:55 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E6211C058;
        Thu,  7 May 2020 14:50:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3F011C04C;
        Thu,  7 May 2020 14:50:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.201])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 May 2020 14:50:54 +0000 (GMT)
Message-ID: <1588863053.5685.62.camel@linux.ibm.com>
Subject: Re: Disparity in tpm pcr5 value
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Ken Goldman <kgold@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Ken Goldman <kgoldman@us.ibm.com>
Date:   Thu, 07 May 2020 10:50:53 -0400
In-Reply-To: <20200507073548.zpyv3u7rv3u7jqrs@cantor>
References: <20200505222731.whnkisag7tlrbcie@cantor>
         <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
         <20200507073548.zpyv3u7rv3u7jqrs@cantor>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_08:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-07 at 00:35 -0700, Jerry Snitselaar wrote:
> On Wed May 06 20, Ken Goldman wrote:
> >On 5/5/2020 6:27 PM, Jerry Snitselaar wrote:
> >>On some systems we've had reports of the value of pcr5 doesn't match 
> >>the digests in the tpm event log.
> >>It looks like I'm able to reproduce here with 5.7-rc4 on a dell 
> >>system using this parser:
> >>
> >>https://github.com/ValdikSS/binary_bios_measurements_parser
> >>
> >>Any thoughts on where to start digging? Is there another tool I 
> >>should use to parse this?
> >
> >If you email me the event log in binary, I can run it through the IBM 
> >calculator and see if I get the same error.
> >
> >
> 
> A couple other data points:
> 
> - On the Dell system where I did this if I change it in the bios to use sha256
>    instead of sha1, then using tsseventextend to parse matches the value in the tpm.
>    In the sha256 case there is a final events log.
> 
> - I have a nuc5 here, which also extends into sha1, and the parse matches there.
> 
> - Javier has also reproduced it when passing through swtpm to a vm.
> 
> - I added some debugging code, and there is nothing extending pcr5 with tpm_pcr_extend.
> 
> - Ken's parse of the log also shows the disparity, which I've now done as well with
>    the tpm1.2 version of the tsseventextend tool.

Thanks, Jerry.  You've eliminated the kernel extending into the PCR.
 For SHA256, the event log has to be TPM 2.0 format.  I've seen TPM
2.0's for SHA1 use the TPM 1.2 event log format.  When using SHA1, is
it a TPM 1.2 or 2.0 event log format?

Mimi
