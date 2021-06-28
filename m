Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802783B69E8
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Jun 2021 22:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhF1UxS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Jun 2021 16:53:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41032 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235419AbhF1UxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Jun 2021 16:53:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15SKXmq5107963;
        Mon, 28 Jun 2021 16:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=dMUtZOFGFK5gHPQELIyLmBwfjmZY+eHlIQuqemhGzuM=;
 b=PaOaHnVs/CIN4QejbPZDBdyCnGZgLK/74q+QwLEhnVqN4Niieo49NUJdLoN3uJGzaoo/
 tl/ksTDCctHLB2SVdHue0oJ/UxmX01PopLDWSClammH9sV+BLNoFfqJINYgYgef5Qx+H
 CM7LIkUpPFZ/SCUx6lcG9GVF88M65FhjmMIKTlgAft02JJ6Ac2C89cLoYTXbKs5HqOoi
 Jji9GtRJmIkYihDXKdSmPQ3+jHt7+qDSHqqLxHOJQeu6/apms6aAvLYtJeC49bJWYB5i
 o+RmhgJ79oUtpOEgRxENXTPYfketo0THDlJMRVMyp3vxjLjzCn6GPBYjr7te3pNA1fYm pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fm5jaej7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 16:50:49 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15SKYtwi114078;
        Mon, 28 Jun 2021 16:50:49 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39fm5jaehc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 16:50:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15SKmweC011079;
        Mon, 28 Jun 2021 20:50:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39duv8gycn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Jun 2021 20:50:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15SKojsZ19202546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 20:50:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58E705206B;
        Mon, 28 Jun 2021 20:50:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.112.169])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 20A055204E;
        Mon, 28 Jun 2021 20:50:42 +0000 (GMT)
Message-ID: <f2355538832153c82c866d1e779b128a9612b6cc.camel@linux.ibm.com>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Date:   Mon, 28 Jun 2021 16:50:42 -0400
In-Reply-To: <20210626004241.wkkjsbbesakszfkj@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-2-vt@altlinux.org>
         <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
         <20210626004241.wkkjsbbesakszfkj@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kLSPRRwmr-UweUGzbd4jaWN7UUB0_8e1
X-Proofpoint-GUID: uqnUaJpIOtjWk0pUvNBR-hP1AaoN1Utn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106280132
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

Thank you for the detailed explanation.

On Sat, 2021-06-26 at 03:42 +0300, Vitaly Chikunov wrote:

> > Requiring the optarg value to be prefixed with "0x" would
> > simplify the strlen test.
> > (The subsequent patch wouldn't need a contrived prefix.)
> 
> (I do not understand this remark at the moment.)
> 
> Base 16 will let user pass keyid just as a string, copy-pasting from
> somewhere else.

strtoul() supports prefixing the ascii-hex string with "0x".  To
differentiate between a keyid and pathname, why not require the keyid
be prefixed with "0x", as opposed to requiring the pathname to be
prefixed with '@', like "--keyid @/path/to/cert.pem".

The new test would be "OPTS=--keyid=0xaabbccdd"

thanks,

Mimi

