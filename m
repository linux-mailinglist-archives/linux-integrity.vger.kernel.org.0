Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E75122943
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Dec 2019 11:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLQKyg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 05:54:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbfLQKyf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 05:54:35 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHArFZm104366
        for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2019 05:54:34 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wwdy0gd3g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Dec 2019 05:54:33 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 17 Dec 2019 10:54:29 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Dec 2019 10:54:26 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBHAsPtf45810072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 10:54:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCE554C046;
        Tue, 17 Dec 2019 10:54:25 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA88F4C050;
        Tue, 17 Dec 2019 10:54:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.199.191])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 10:54:24 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] IMA: Define workqueue for early boot "key"
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 17 Dec 2019 05:54:24 -0500
In-Reply-To: <0223b52e-50d6-ebce-840c-0364b24b1b30@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-2-nramas@linux.microsoft.com>
         <1576499400.4579.305.camel@linux.ibm.com>
         <0223b52e-50d6-ebce-840c-0364b24b1b30@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121710-0016-0000-0000-000002D5BC41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121710-0017-0000-0000-00003337F4C9
Message-Id: <1576580064.4579.374.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-16,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=958 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170094
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-16 at 15:44 -0800, Lakshmi Ramasubramanian wrote:
> On 12/16/2019 4:30 AM, Mimi Zohar wrote:
> 
> >> +
> >> +		if (!list_empty(&ima_keys)) {
> >> +			list_for_each_entry_safe(entry, tmp, &ima_keys, list)
> >> +				list_move_tail(&entry->list, &temp_ima_keys);
> >> +			process = true;
> >> +		}
> >> +	}
> >> +
> >> +	mutex_unlock(&ima_keys_mutex);
> >> +
> >> +	if (!process)
> >> +		return;
> > 
> > The new changes - checking if the list is empty and this test - are
> > unnecessary, as you implied earlier.
> > 
> > Mimi
> 
> Do you want me to remove this check? I feel it is safer to have this 
> check - use a local flag "process" to return if no keys were moved to 
> the temp list. Would like to leave it as is - if you don't mind.

Sure
  

