Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5E83B4315
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYMYo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:24:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229498AbhFYMYo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:24:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCHJNj194375;
        Fri, 25 Jun 2021 08:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=1+0FHs2bhxqrJedHmjSmSwi3GMkSN1oQs1QgygzoEVQ=;
 b=hAVQYEsQ2vi0hWoxXIMa4hq7+tESGyf73SLlWlANqCQnxT6LaP9M61v2CFg645OPNWpo
 wt659zlf4vs7Zz+rNWb68/mzM+PDvlA0WM3NKB2uqt238gML6NZOee2i68GdD4ky7Nf9
 UaMr49Gb3trGioMzt9q1eoFJpLTQZTS+K1pNCemZ7OLFaosi/YrQRA8WWNwmx2dgCASp
 9KBTtXntTm6pSJwSJstC4iBhvlzxMBfM/sMbpxgmAZxKzkZ9OGrzyyZZ/enYtNuwI47W
 L9t5tYD176jqxIARoTLNmpVsu8jN8fo3YG1RbMUccYmK9lnCmE10Ejf1SpKWJy31nuTN UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dek4h4yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:22:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PCHh8J196002;
        Fri, 25 Jun 2021 08:22:22 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39dek4h4xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:22:22 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PCDjwA027877;
        Fri, 25 Jun 2021 12:22:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3998789pgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 12:22:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PCMHr919529988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:22:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D653811C058;
        Fri, 25 Jun 2021 12:22:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B65E911C054;
        Fri, 25 Jun 2021 12:22:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.9.226])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 12:22:16 +0000 (GMT)
Message-ID: <5a526d9dd5dcd227c4f85e8a3b9ae504ea97c438.camel@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 25 Jun 2021 08:22:15 -0400
In-Reply-To: <20210511115630.795208-4-vt@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
         <20210511115630.795208-4-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eyIWv82u2cZ6wzlvjder7t7Dh2LJlV9e
X-Proofpoint-GUID: -q2sjn_0SP-bk4ei2eVVjt7e2keroqd7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_04:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> Allow to have certificate appended to the private key of `--key'
> specified (PEM) file (for v2 signing) to facilitate reading of keyid
> from the associated cert. This will allow users to have private and
> public key as a single file. There is no check that public key form the
> cert matches associated private key.

Is this a standard formats for storing the public and private key in
the same file?

Mimi

