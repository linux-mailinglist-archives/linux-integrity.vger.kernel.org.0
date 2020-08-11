Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA511241CA4
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Aug 2020 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgHKOpC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Aug 2020 10:45:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgHKOpB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Aug 2020 10:45:01 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07BEXYLl078100;
        Tue, 11 Aug 2020 10:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NSBBKixe65/2LVnlvxnGslsqyJo3+Zs4iFXWLgw655Q=;
 b=EeYaqza8YvCS2AdgMlMbfaclCLeu8Uvj6ETtKiPi0rk7tEK78ICk66Z9kL/JdSZVjpLv
 h21j6IhDy8/sVfCVGok0y6I5FCidBq/e9vN8lERWZbz6hmm+s5u2vRC39ui5uSKnWVzP
 iAes1Wy0MMJoAYo2lopY+W794PR/7iOLZ3Mpe1K7Skg3QDIGDjcOTYFS94IVZE2x9Unz
 ai1BImBO07woGblnHXRT7TDYKoBtPkiA6+Nr4nPYoE50bzxnAoefZvEy5yzWEcg7mRmc
 tMnIMp6NkD61+sVkXOuUa2ux0sDprgOAqNeSMYWAM+mWlAY/Kmq+QCMkER42i0Zl+yAF Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32us5k0cwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 10:44:57 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07BEXcH0078596;
        Tue, 11 Aug 2020 10:44:57 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32us5k0cw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 10:44:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07BEfslD007315;
        Tue, 11 Aug 2020 14:44:54 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 32skahbfwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Aug 2020 14:44:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07BEiq4x25493894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 14:44:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 478F942042;
        Tue, 11 Aug 2020 14:44:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2893342049;
        Tue, 11 Aug 2020 14:44:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Aug 2020 14:44:50 +0000 (GMT)
Message-ID: <ae1ad8314236a3e93731e8a57e6dae7170e90b05.camel@linux.ibm.com>
Subject: ima-evm-utils: version 1.3.1 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Tue, 11 Aug 2020 10:44:50 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-11_13:2020-08-11,2020-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ima-evm-utils v1.3.1 release addresses a couple of distro v1.3
build issues.  A few additional changes, that were not quite ready for
the 1.3 release, are included as well.

(Not included in this release is the travis branch.)

For details refer to "NEWS" for a short summary of these changes.

thanks,

Mimi

