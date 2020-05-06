Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138CB1C7285
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2020 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEFOMz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 May 2020 10:12:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgEFOMz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 May 2020 10:12:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 046EAHUs006147;
        Wed, 6 May 2020 10:12:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4v99xvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 10:12:52 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046EATHS007275;
        Wed, 6 May 2020 10:12:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4v99xvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 10:12:51 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046E9mdP018410;
        Wed, 6 May 2020 14:12:51 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 30s0g71r74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 14:12:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 046ECnfJ25362912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 May 2020 14:12:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 552FD13605D;
        Wed,  6 May 2020 14:12:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4CB0136051;
        Wed,  6 May 2020 14:12:49 +0000 (GMT)
Received: from [9.80.233.98] (unknown [9.80.233.98])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 May 2020 14:12:49 +0000 (GMT)
Subject: Re: Disparity in tpm pcr5 value
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@google.com>,
        Ken Goldman <kgoldman@us.ibm.com>
References: <20200505222731.whnkisag7tlrbcie@cantor>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <4b3be2e9-35f7-d730-8e3b-b252ba5cb095@linux.ibm.com>
Date:   Wed, 6 May 2020 10:12:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505222731.whnkisag7tlrbcie@cantor>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_07:2020-05-05,2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/5/2020 6:27 PM, Jerry Snitselaar wrote:
> On some systems we've had reports of the value of pcr5 doesn't match the 
> digests in the tpm event log.
> It looks like I'm able to reproduce here with 5.7-rc4 on a dell system 
> using this parser:
> 
> https://github.com/ValdikSS/binary_bios_measurements_parser
> 
> Any thoughts on where to start digging? Is there another tool I should 
> use to parse this?

If you email me the event log in binary, I can run it through the IBM 
calculator and see if I get the same error.


